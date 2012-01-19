package WDB::Result::CurrentParagraph;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

WDB::Result::CurrentParagraph

=cut

__PACKAGE__->table("current_paragraph");

=head1 ACCESSORS

=head2 paragraph

  data_type: 'integer'
  is_nullable: 1

=head2 revision

  data_type: 'integer'
  is_nullable: 1

=head2 date_created

  data_type: 'integer'
  is_nullable: 1

=head2 derived

  data_type: 'boolean'
  is_nullable: 1

=head2 parent

  data_type: 'integer'
  is_nullable: 1

=head2 idea

  data_type: 'text'
  is_nullable: 1

=head2 essay

  data_type: 'integer'
  is_nullable: 1

=head2 words

  data_type: 'text[]'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "paragraph",
  { data_type => "integer", is_nullable => 1 },
  "revision",
  { data_type => "integer", is_nullable => 1 },
  "date_created",
  { data_type => "integer", is_nullable => 1 },
  "derived",
  { data_type => "boolean", is_nullable => 1 },
  "parent",
  { data_type => "integer", is_nullable => 1 },
  "idea",
  { data_type => "text", is_nullable => 1 },
  "essay",
  { data_type => "integer", is_nullable => 1 },
  "words",
  { data_type => "text[]", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-17 14:46:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jr2GTcJQkiQveau2vztMUQ

__PACKAGE__->set_primary_key("paragraph", "essay");


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
