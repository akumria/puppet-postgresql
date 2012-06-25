Puppet::Type.type(:pg_user).provide(:debian_postgresql) do

  desc "Manage users for a postgres database cluster"

  defaultfor :operatingsystem => [:debian, :ubuntu]

  optional_commands :psql => 'psql'
  optional_commands :su => 'su'

  def create
    stm = "create role %s encrypted password '%s'" % [\
        @resource.value(:name), @resource.value(:password) ]

    if @resource.value(:login) == true
        stm = stm + " login"
    else
        stm = stm + " nologin"
    end

    if @resource.value(:superuser) == true
        stm = stm + " superuser"
    else
        stm = stm + " nosuperuser"
    end

    if @resource.value(:inherit) == true
        stm = stm + " inherit"
    else
        stm = stm + " noinherit"
    end

    if @resource.value(:createrole) == true
        stm = stm + " createrole"
    else
        stm = stm + " nocreaterole"
    end

    su("-", "postgres", "-c", "psql -c \"%s\"" % stm)
  end

  def destroy
    su("-", "postgres", "-c", "dropuser %s" % [ @resource.value(:name) ])
  end

  def exists?
    su_output = su("-", "postgres", "-c", "psql --quiet -A -t -c \"select 1 from pg_roles where rolname = '%s';\"" % @resource.value(:name))
    return false if su_output.length == 0
    su_output.each do |line|
      if line == "1\n"
        return true
      else
        return false
      end
    end
  end

end
