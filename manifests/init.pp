class pow {
  $POW_ROOT = "/Users/${id}/Library/Application Support/Pow"
  $POW_BIN = "${POW_ROOT}/Current/bin"

  file { "${POW_ROOT}": ensure => directory }
  file { "${POW_ROOT}/Hosts": ensure => directory }
  file { "${POW_ROOT}/Versions": ensure => directory }

  file { "/Users/${id}/.pow": ensure => link, target => "${POW_ROOT}/Hosts" }
  file { "${POW_ROOT}/Current": ensure => link, target => "${POW_ROOT}/Versions/0.4.0", replace => false }

  exec { "Installing Pow v0.4.0":
    command => "/usr/bin/curl -s http://get.pow.cx/versions/0.4.0.tar.gz | /usr/bin/tar xf -",
    creates => "${POW_ROOT}/Versions/0.4.0",
    cwd     => "${POW_ROOT}/Versions",
    require => [File["${POW_ROOT}/Versions"]],
  }

  $plist = "/Users/${id}/Library/LaunchAgents/cx.pow.powd.plist"
  exec { "Configuring Launch Agents":
    command     => "node ./pow --install-local",
    cwd         => $POW_BIN,
    path        => [$POW_BIN, '/usr/bin'],
    environment => ["HOME=/Users/${id}", "LOGNAME=${id}"],
    creates     => $plist,
    require     => [Exec["Installing Pow v0.4.0"]],
    notify      => [Exec["Starting Pow"]],
  }

  exec { "Starting Pow":
    command     => "/bin/launchctl load ${plist}",
    refreshonly => true,
  }
}