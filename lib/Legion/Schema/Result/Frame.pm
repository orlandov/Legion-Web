package Legion::Schema::Result::Frame;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("frame");
__PACKAGE__->add_columns(
  "frame_id",
  {
    data_type => "integer",
    default_value => "nextval('frame_frame_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "frame_number",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "renderjob_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sha1",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "render_elapsed",
  {
    data_type => "double precision",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
  "status",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("frame_id");
__PACKAGE__->add_unique_constraint("frame_pkey", ["frame_id"]);
__PACKAGE__->belongs_to(
  "renderjob_id",
  "Legion::Schema::Result::Renderjob",
  { renderjob_id => "renderjob_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-07-29 21:26:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yhutH438cEi5TfAC0vBluQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
