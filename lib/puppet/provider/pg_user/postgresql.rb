Puppet::Type.type(:pg_user).provide(:debian_postgresql) do

  desc "Manage users for a postgres database cluster"

  confine :operatingsystem => [:debian, :ubuntu]

  optional_commands :psql => 'psql'
  optional_commands :su => 'su'

  def create
    su("-", "postgres", "-c", "psql -c \"create role %s encrypted password '%s'\"" % [ @resource.value(:name), @resource.value(:password) ])
  end

  def destroy
    fail('not yet done')
  end

  def exists?
    not su("-", "postgres", "-c", "psql --quiet -A -t -c \"select 1 from pg_roles where rolname = '%s';\"" % @resource.value(:name))
  end

end
