#!/bin/bash
#
# VSH Script
# Coded by Julien Grave and Lucas Lonk.

# Include all source files
source vsh_common.sh
source vsh_client.sh

# Launch the server on the specified port
start_server() {
  if ! [[ -z $(pgrep -lf "$SERVER") ]]; then
    echo "Server already running on port $1."
    exit 1
  else 
    echo 'Launching server...'
    rm -f /tmp/serverFifo
    mknod /tmp/serverFifo p
    $SERVER "$SCRIPT" &
    echo "Server is now listening on port $1."
  fi
}

# Stop the server according to the specified port
stop_server() {
  local test=$(pgrep -lf "$SERVER" | cut -d' ' -f1)
  if ! [[ -z $test ]]; then
    echo "Stopping server listening on port $1..."
    kill $test
    rm -f /tmp/serverFifo
    echo 'Server stopped!'
  else
    echo "There is no server running on port $1."
    exit 1
  fi
}

# Main function
main() {
  # Declaration of global variables to make life easier
  if [[ $1 == "-list" || $1 == "-browse" || $1 == "-extract" ]]; then
    DESTINATION=$2
    PORT=$3
    ARCHIVE=$4
  elif [[ $1 == "-start" || $1 == "-stop" ]]; then
    if ! [[ -z $3 ]]; then
      ARCHIVE=$3
    else
      ARCHIVE="archives"
    fi
    SCRIPT="./vsh_server.sh $ARCHIVE"
    SERVER="ncat -lk localhost 1337 -c" # -e option to handle multiples connections seperately and avoid broadcasting server response to everyone
  fi

  # Check everything
  check_arguments "$@"
  #check_config # Disable to avoid cross-platform problem

  # Let's go
  execute_command "$@"
}

main "$@"
exit 0
