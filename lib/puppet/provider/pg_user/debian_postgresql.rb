Puppet::Type.type(:pg_user).provide(:debian_postgresql) do

  desc "Manage users for a postgres database cluster"

  defaultfor :operatingsystem => [:debian, :ubuntu]

  optional_commands :psql => 'psql'
  optional_commands :su => 'su'

  def create

    if @resource.value(:password)
      password_string = " encrypted password '%s'" % @resource.value(:password)
    end

    stm = "create role %s#{password_string}" % @resource.value(:name)

    if @resource.value(:createdb) == true
        stm = stm + " createdb"
    else
        stm = stm + " nocreatedb"
    end

    if @resource.value(:inherit) == false
        stm = stm + " noinherit"
    else
        stm = stm + " inherit"
    end

    if @resource.value(:login) == false
        stm = stm + " nologin"
    else
        stm = stm + " login"
    end

    if @resource.value(:createrole) == true
        stm = stm + " createrole"
    else
        stm = stm + " nocreaterole"
    end

    if @resource.value(:superuser) == true
        stm = stm + " superuser"
    else
        stm = stm + " nosuperuser"
    end

    su("-", "postgres", "-c", "psql -c \"%s\"" % stm)
  end

  def destroy
    su("-", "postgres", "-c", "dropuser %s" % [ @resource.value(:name) ])
  end

  def exists?
    su_output = su("-", "postgres", "-c", "psql --quiet -A -t -c \"select 1 from pg_roles where rolname = '%s';\"" % @resource.value(:name))
    return false if su_output.length == 0
    su_output.each_line do |line|
      if line == "1\n"
        return true
      else
        return false
      end
    end
  end

end
