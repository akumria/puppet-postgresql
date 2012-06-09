Puppet::Type.type(:pg_user).provide(:debian_postgresql) do

  desc "Manage users for a postgres database cluster"

  confine :operatingsystem => [:debian, :ubuntu]

  optional_commands :psql => 'psql'

  def create
    return false
  end

  def destroy
    return false
  end

  def exists?
    not psql("psql", "-c", "select 1 from pg_role where rolname = '%s'" % @resource.value(:name)).empty?
  end

end
