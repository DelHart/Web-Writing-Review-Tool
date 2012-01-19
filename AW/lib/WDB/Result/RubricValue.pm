package WDB::Result::RubricValue;

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

WDB::Result::RubricValue

=cut

__PACKAGE__->table("rubric_value");

=head1 ACCESSORS

=head2 rubric

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 value

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 information

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "rubric",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "value",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "information",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("rubric", "value");

=head1 RELATIONS

=head2 rubric

Type: belongs_to

Related object: L<WDB::Result::Rubric>

=cut

__PACKAGE__->belongs_to(
  "rubric",
  "WDB::Result::Rubric",
  { rubric => "rubric" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-02 15:40:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lNFzE0QhOu3LVmKhNOVulA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
