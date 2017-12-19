# Add the Varnish repo
class varnish::repo::debian {
    include ::packagecloud

    $ver = delete($::varnish::varnish_version,'.')

    if $ver <= "30" and $::lsbdistcodename == "xenial" {
      $dist = "trusty"
    } else {
      $dist = $::lsbdistcodename
    }

    ::packagecloud::repo { 'varnish-cache':
      fq_name => "varnishcache/varnish${ver}",
      type    => 'deb',
      distribution => $dist,
    }

    exec { 'varnish-cache apt-update':
      command     => 'apt-get update',
      refreshonly => true,
      subscribe   => Packagecloud::Repo['varnish-cache'],
      path        => '/usr/bin:/usr/sbin',
    }
}
