package WDB::Result::CurrentEssay;

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

WDB::Result::CurrentEssay

=cut

__PACKAGE__->table("current_essay");

=head1 ACCESSORS

=head2 essay

  data_type: 'integer'
  is_nullable: 1

=head2 revision

  data_type: 'integer'
  is_nullable: 1

=head2 date_created

  data_type: 'integer'
  is_nullable: 1

=head2 author

  data_type: 'integer'
  is_nullable: 1

=head2 derived

  data_type: 'boolean'
  is_nullable: 1

=head2 parent

  data_type: 'integer'
  is_nullable: 1

=head2 title

  data_type: 'text'
  is_nullable: 1

=head2 status

  data_type: 'integer'
  is_nullable: 1

=head2 approach

  data_type: 'text'
  is_nullable: 1

=head2 assignment

  data_type: 'integer'
  is_nullable: 1

=head2 counter

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "essay",
  { data_type => "integer", is_nullable => 1 },
  "revision",
  { data_type => "integer", is_nullable => 1 },
  "date_created",
  { data_type => "integer", is_nullable => 1 },
  "author",
  { data_type => "integer", is_nullable => 1 },
  "derived",
  { data_type => "boolean", is_nullable => 1 },
  "parent",
  { data_type => "integer", is_nullable => 1 },
  "title",
  { data_type => "text", is_nullable => 1 },
  "status",
  { data_type => "integer", is_nullable => 1 },
  "approach",
  { data_type => "text", is_nullable => 1 },
  "assignment",
  { data_type => "integer", is_nullable => 1 },
  "counter",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-17 10:37:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6FL+TcDOu+iUKuKbUGP2nA

__PACKAGE__->set_primary_key("essay");

__PACKAGE__->has_many(
  "assignment_people",
  "WDB::Result::AssignmentPerson",
  {
    "foreign.essay"    => "self.essay"
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
  "pars",
  "WDB::Result::EssayPars",
  {
    "foreign.essay"    => "self.essay",
    "foreign.essay_rev"    => "self.revision"
  },
  { cascade_copy => 0, cascade_delete => 0, order_by => \'num ASC' },
);

__PACKAGE__->has_many(
  "erefs",
  "WDB::Result::EssayEref",
  {
    "foreign.essay"    => "self.essay",
    "foreign.essay_rev"    => "self.revision"
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
