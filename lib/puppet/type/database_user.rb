# This has to be a separate type to enable collecting
Puppet::Type.newtype(:database_user) do
  @doc = "Manage a database user/role."

  ensurable

  newparam(:name, :namevar=>true) do
    desc "The name of the user/role"
  end

  newparam(:createdb) do
    desc "Is the user allowed to create databases."

    defaultto :false

    newvalue(:true)
    newvalue(:false)
  end

  newparam(:inherit) do
    desc "Inherit privileges of roles this user/role is a member of."

    defaultto :true

    newvalue(:true)
    newvalue(:false)
  end

  newparam(:login) do
    desc "Can the user/role/ login?"

    defaultto :true

    newvalue(:true)
    newvalue(:false)
  end

  newparam(:createrole) do
    desc "Can the user/role create other users/roles?"

    defaultto :false

    newvalue(:true)
    newvalue(:false)
  end

  newparam(:superuser) do
    desc "Is the user/role a superuser?"

    defaultto :false

    newvalue(:true)
    newvalue(:false)
  end

end
