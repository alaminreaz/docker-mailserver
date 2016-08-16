@test "checking process: process is running" {
  run docker exec mail /bin/bash -c "ps aux | grep 'dovecot/pop'"
  [ "$status" -eq 0 ]
}

@test "checking pop: server responds on port 110" {
  run docker exec mail /bin/bash -c "nc -w 1 0.0.0.0 110 | grep '+OK'"
  [ "$status" -eq 0 ]
}

@test "checking pop: authentication works" {
  run docker exec mail /bin/sh -c "nc -w 1 0.0.0.0 110 < /tmp/docker-mailserver-test/auth/pop3-auth.txt"
  [ "$status" -eq 0 ]
}
