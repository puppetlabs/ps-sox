## Reference: http://www.stigviewer.com/stig/red_hat_enterprise_linux_5/2014-04-02/finding/V-845
class sox::ftplogging (
  $fixit = true,
) {

  tag 'SV-37547r1_rule', '11.1'

  if $fixit {
    case $operatingsystemmajrelease {
      /5|6/: {
        augeas { 'vsftpd logging':
          context => '/etc/vsftpd/vsftpd.conf',
          changes => 'set log_ftp_protocol YES',
        }

        if !defined(Service['vsftpd']) {
          service { 'vsftpd':
            subscribe => Augeas['vsftpd logging'],
          }
        }
        else {
          Service <| title == 'vsftpd' |> {
            subscribe +> Augeas['vsftpd logging'],
          }
        }
      }

      '4': {
        augeas { 'gssftp logging':
          context => '/files/etc/xinetd.d/gssftp/service',
          changes => 'set server_args/value[last() + 1] "-l"',
          onlyif  => "match server_args/value[. =~ regexp('-l+')] size == 0",
        }
      }

      /7|2/: {
        augeas { 'wu-ftpd logging':
          context => '/files/etc/xinetd.d/wu-ftpd/service',
          changes => 'set server_args/value[last() + 1] "-l"',
          onlyif  => "match server_args/value[. =~ regexp('-l+')] size == 0",
        }
      }

      default: {
        fail("${operatingsystem} ${operatingsystemmajrelease} is not supported")
      }
    }
  }

}
