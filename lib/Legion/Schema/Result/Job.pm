package Legion::Schema::Result::Job;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("job");
__PACKAGE__->add_columns(
  "jobid",
  {
    data_type => "integer",
    default_value => "nextval('job_jobid_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "funcid",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "arg",
  {
    data_type => "bytea",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "uniqkey",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "insert_time",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "run_after",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "grabbed_until",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "priority",
  {
    data_type => "smallint",
    default_value => undef,
    is_nullable => 1,
    size => 2,
  },
  "coalesce",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->add_unique_constraint("job_funcid_key", ["funcid", "uniqkey"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-07-23 22:06:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:elgky+R3WgA0ESqTka74Nw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
