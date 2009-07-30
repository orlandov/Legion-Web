package Legion::Schema::Result::Renderjob;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("renderjob");
__PACKAGE__->add_columns(
  "renderjob_id",
  {
    data_type => "integer",
    default_value => "nextval('renderjob_renderjob_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "source_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "status",
  {
    data_type => "character varying",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("renderjob_id");
__PACKAGE__->add_unique_constraint("renderjob_pkey", ["renderjob_id"]);
__PACKAGE__->has_many(
  "frames",
  "Legion::Schema::Result::Frame",
  { "foreign.renderjob_id" => "self.renderjob_id" },
);
__PACKAGE__->belongs_to(
  "source_id",
  "Legion::Schema::Result::Source",
  { source_id => "source_id" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-07-29 21:26:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lEvFZu+A7ZzdacfEPouxfw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
