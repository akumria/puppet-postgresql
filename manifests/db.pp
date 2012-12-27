define postgresql::db (
    $password,
    $ensure   = present,
    $owner    = $name,
    $encoding = 'UTF8',
    $locale   = 'en_US.UTF-8',
    $template = 'template0',
) {
    require postgresql::server

    pg_user {$owner:
        ensure      => $ensure,
        password    => $password,
    }

    pg_database {$name:
        ensure      => $ensure,
        owner       => $owner,
        require     => Pg_user[$owner],
        encoding    => $encoding,
        locale      => $locale,
        template    => $template,
    }
}
