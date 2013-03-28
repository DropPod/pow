class pow::sudo::post {
  $POW_ROOT = "/Users/${id}/Library/Application Support/Pow"
  $POW_BIN = "${POW_ROOT}/Current/bin"

  exec { "Configuring Launch Daemons":
    command     => "node ./pow --install-system",
    cwd         => $POW_BIN,
    path        => [$POW_BIN, '/usr/bin', '/usr/sbin'],
    environment => ["HOME=/Users/${id}", "LOGNAME=${id}"],
    creates     => "/Library/LaunchDaemons/cx.pow.firewall.plist",
    notify      => [Service["cx.pow.firewall"]],
  }

  service { "cx.pow.firewall": ensure => running }
}