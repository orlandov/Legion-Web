package Legion::Schema::Result::Source;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("source");
__PACKAGE__->add_columns(
  "file_id",
  {
    data_type => "integer",
    default_value => "nextval('source_file_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "filename",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "filesize",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sha1",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("file_id");
__PACKAGE__->add_unique_constraint("source_pkey", ["file_id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-07-19 21:14:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:j93PK0OvykH+n2o/qIT+UQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;