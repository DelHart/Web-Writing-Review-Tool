package WDB::Result::Rubric;

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

WDB::Result::Rubric

=cut

__PACKAGE__->table("rubric");

=head1 ACCESSORS

=head2 rubric

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 info

  data_type: 'text'
  is_nullable: 1

=head2 kind

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "rubric",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "info",
  { data_type => "text", is_nullable => 1 },
  "kind",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("rubric");

=head1 RELATIONS

=head2 rubric_values

Type: has_many

Related object: L<WDB::Result::RubricValue>

=cut

__PACKAGE__->has_many(
  "rubric_values",
  "WDB::Result::RubricValue",
  { "foreign.rubric" => "self.rubric" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-02 15:40:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Qx1Eu62h6EoEb7sz6tCgsQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
