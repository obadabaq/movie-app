abstract class ExploreEvent {}

class InitExplore extends ExploreEvent {}

class ChangedSearch extends ExploreEvent {
  final String query;

  ChangedSearch(this.query);
}

class ScrollMore extends ExploreEvent {}
