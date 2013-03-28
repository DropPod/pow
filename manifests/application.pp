define pow::application {
  $path = inline_template("/Users/<%= @id %>/.pow/<%= File.basename(@name) %>")
  file { "${path}": ensure => link, target => $title }
}
