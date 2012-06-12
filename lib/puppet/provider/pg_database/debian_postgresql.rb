Puppet::Type.type(:pg_database).provide(:debian_postgresql) do

  desc "Manage users for a postgres database cluster"

  defaultfor :operatingsystem => [:debian, :ubuntu]

  optional_commands :psql => 'psql'
  optional_commands :su => 'su'

  def create
    su("-", "postgres", "-c", "createdb -E %s -O %s %s" % [ @resource.value(:charset), @resource.value(:owner), @resource.value(:name) ])
  end

  def destroy
    su("-", "postgres", "-c", "dropdb %s" % [ @resource.value(:name) ])
  end

  def exists?
    not su("-", "postgres", "-c", "psql --quiet -A -t -c \"select 1 from pg_database where datname = '%s';\"" % @resource.value(:name))
  end

end
