package Legion::Schema::Result::Project;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("project");
__PACKAGE__->add_columns(
  "project_id",
  {
    data_type => "integer",
    default_value => "nextval('project_project_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "source_id",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("project_id");
__PACKAGE__->add_unique_constraint("project_pkey", ["project_id"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-07-19 22:19:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zS0uuMHvLqoyq2ztUCR4RQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
