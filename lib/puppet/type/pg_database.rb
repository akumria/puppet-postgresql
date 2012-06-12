# This has to be a separate type to enable collecting
Puppet::Type.newtype(:pg_database) do
  @doc = "Manage Postgresql databases."

  ensurable

  newparam(:name, :namevar=>true) do
    desc "The name of the database."
  end

  newparam(:charset) do
    desc "The character set to use for the database"
    defaultto :utf8
    newvalue(/^\S+$/)
  end

  newparam(:owner) do
    desc "The owner of the database"
    defaultto :postgres
    newvalue(/^\S+$/)
  end

end
