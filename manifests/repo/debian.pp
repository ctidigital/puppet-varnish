# Add the Varnish repo
class varnish::repo::debian {
    include ::packagecloud

    $ver = delete($::varnish::varnish_version,'.')

    # TODO: Determine how the $dist parameter is used (there is no
    # 'distribution' parameter to '::packagecloud::repo')
    if $ver <= "30" and $::lsbdistcodename == "xenial" {
      $dist = "trusty"
    } else {
      $dist = $::lsbdistcodename
    }

    ::packagecloud::repo { 'varnish-cache':
      fq_name => "varnishcache/varnish${ver}",
      type    => 'deb',
    }

    exec { 'varnish-cache apt-update':
      command     => 'apt-get update',
      refreshonly => true,
      subscribe   => Packagecloud::Repo['varnish-cache'],
      path        => '/usr/bin:/usr/sbin',
    }
}
