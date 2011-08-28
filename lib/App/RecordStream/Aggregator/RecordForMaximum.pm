package App::RecordStream::Aggregator::RecordForMaximum;

use strict;
use lib;

use base 'App::RecordStream::Aggregator::MapReduce';

sub new
{
   my $class = shift;
   my ($field) = @_;

   my $this =
   {
      'field' => $field,
   };
   bless $this, $class;

   return $this;
}

sub map
{
   my ($this, $record) = @_;

   my $value = ${$record->guess_key_from_spec($this->{'field'})};

   return [$value, $record];
}

sub reduce
{
   my ($this, $cookie1, $cookie2) = @_;

   my ($v1, $r1) = @$cookie1;
   my ($v2, $r2) = @$cookie2;

   if($v1 > $v2)
   {
      return $cookie1;
   }

   return $cookie2;
}

sub squish
{
   my ($this, $cookie) = @_;

   my ($v, $r) = @$cookie;

   return $r;
}

sub argct
{
   return 1;
}

sub short_usage
{
   return "returns the record corresponding to the maximum value for a field";
}

sub long_usage
{
   print "Usage: recformax,<field>\n";
   print "   The record corresponding to the maximum value of specified field.\n";
   exit 1;
}

sub returns_record
{
   return 1;
}

App::RecordStream::Aggregator::register_aggregator('recformax', __PACKAGE__);
App::RecordStream::Aggregator::register_aggregator('recformaximum', __PACKAGE__);
App::RecordStream::Aggregator::register_aggregator('recordformax', __PACKAGE__);
App::RecordStream::Aggregator::register_aggregator('recordformaximum', __PACKAGE__);

1;
