# Tmuxall

[![Code Climate](https://codeclimate.com/github/v-yarotsky/tmuxall.png)](https://codeclimate.com/github/v-yarotsky/tmuxall)
[![Build Status](https://travis-ci.org/v-yarotsky/tmuxall.png?branch=master)](https://travis-ci.org/v-yarotsky/tmuxall)
[![Gem Version](https://badge.fury.io/rb/tmuxall.png)](http://badge.fury.io/rb/tmuxall)

An utility to launch multiple commands inside tmux session with custom layouts

## Installation

    $ gem install tmuxall

## Usage

Tmuxall accepts commands to execute either via parameters or via stdin

Example usage:

    $ tmuxall 'echo hello' 'echo bye' 'ls -la'

    $ cat | tmuxall
    > echo hello
    > echo bye
    > ls \
    > -la
    > <Ctrl-D>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
