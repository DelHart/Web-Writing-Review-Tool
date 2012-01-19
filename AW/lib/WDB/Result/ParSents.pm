package WDB::Result::ParSents;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("par_sents");
__PACKAGE__->add_columns(
  "paragraph",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "paragraph_rev",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sentence",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "sentence_rev",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
  "num",
  { data_type => "integer", default_value => undef, is_nullable => 0, size => 4 },
);
__PACKAGE__->set_primary_key("paragraph", "paragraph_rev", "sentence", "sentence_rev", "num");
__PACKAGE__->add_unique_constraint(
  "par_sents_pkey",
  ["paragraph", "paragraph_rev", "sentence", "sentence_rev", "num"],
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2011-07-09 14:17:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cBGxUBtgcsUok7l5R4nfUA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
