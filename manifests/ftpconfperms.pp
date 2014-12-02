## Ensure the FTP configuration files have restrictive file modes and
## root ownership/group
class sox::ftpconfperms (
  $fixit = true,
) {

  tag '11.2'

  if $fixit {

    case $operatingsystemmajrelease {
      /5|6/: {
        $file = '/etc/vsftpd/vsftpd.conf'
      }
      '4': {
        $file = '/etc/xinetd.d/gssftp'
      }
      /7|2/: {
        $file = '/etc/xinetd.d/wu-ftpd'
      }
      default: {
        fail("${operatingsystem} ${operatingsystemmajrelease} is not supported")
      }
    }

    file { $file:
      mode  => '0600',
      owner => 'root',
      group => 'root',
    }

  }
}
