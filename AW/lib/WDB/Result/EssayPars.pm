package WDB::Result::EssayPars;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("essay_pars");
__PACKAGE__->add_columns(
  "essay",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "essay_rev",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "paragraph",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "paragraph_rev",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "num",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("essay", "essay_rev", "paragraph", "paragraph_rev", "num");
__PACKAGE__->add_unique_constraint(
  "essay_pars_pkey",
  ["essay", "essay_rev", "paragraph", "paragraph_rev", "num"],
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2011-07-09 14:17:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:j3RztL0eizeAjNCbWy+Cwg

__PACKAGE__->belongs_to(
  "par",
  "WDB::Result::Paragraph",
  {
    "foreign.paragraph"    => "self.paragraph",
    "foreign.revision"     => "self.paragraph_rev"
  },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

__PACKAGE__->belongs_to(
  "essay",
  "WDB::Result::Essay",
  {
    "foreign.essay"    => "self.essay",
    "foreign.revision"     => "self.essay_rev"
  },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# You can replace this text with custom content, and it will be preserved on regeneration
1;
