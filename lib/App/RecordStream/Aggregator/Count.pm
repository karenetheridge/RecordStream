package App::RecordStream::Aggregator::Count;

use strict;
use lib;

use App::RecordStream::Aggregator::MapReduce;
use App::RecordStream::Aggregator;

use base 'App::RecordStream::Aggregator::MapReduce';

sub new
{
   my ($class, @args) = @_;
   return $class->SUPER::new(@args);
}

sub map
{
   return 1;
}

sub reduce
{
   my ($this, $cookie, $cookie2) = @_;

   return $cookie + $cookie2;
}

sub argct
{
   return 0;
}

sub long_usage
{
   print "Usage: count\n";
   print "   Counts number of (non-unique) records.\n";
   exit 1;
}

sub short_usage
{
   return "counts (non-unique) records";
}

App::RecordStream::Aggregator::register_aggregator('count', __PACKAGE__);
App::RecordStream::Aggregator::register_aggregator('ct', __PACKAGE__);

1;
