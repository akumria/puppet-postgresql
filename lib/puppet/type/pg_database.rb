# This has to be a separate type to enable collecting
Puppet::Type.newtype(:pg_database) do
  @doc = "Manage Postgresql databases."

  ensurable

  newparam(:name, :namevar=>true) do
    desc "The name of the database."
  end

  newparam(:encoding) do
    desc "The character set to use for the database"

    defaultto :UTF8
  end

  newparam(:owner) do
    desc "The owner of the database"

    defaultto :postgres
  end

end
