source ~/.rvm/scripts/rvm

rvm use ruby-1.8.7
ruby rbench.rb --html

rvm use ruby-1.9.3
ruby rbench.rb --html

rvm use ruby-2.0.0
ruby rbench.rb --html

rvm use ruby-2.2.1
ruby rbench.rb --html

rvm use rbx-2.5.2
ruby rbench.rb --html

rvm use jruby-1.7.19
ruby rbench.rb --html