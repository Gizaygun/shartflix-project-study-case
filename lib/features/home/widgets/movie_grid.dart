import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/movies_provider.dart';
import 'movie_tile.dart';

class MovieGrid extends StatefulWidget {
  const MovieGrid({super.key});
  @override
  State<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final prov = context.read<MoviesProvider>();
    prov.refresh();
    _controller.addListener(() {
      if (_controller.position.pixels > _controller.position.maxScrollExtent - 600) {
        prov.loadNext();
      }
    });
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, m, __) {
        if (m.items.isEmpty && m.loading) return const _SkeletonGrid();
        if (m.items.isEmpty) {
          return const Center(child: Text('Film bulunamadı', style: TextStyle(color: Colors.white70)));
        }
        return CustomScrollView(
          controller: _controller,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, i) => MovieTile(index: i),
                  childCount: m.items.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2/3, // poster oranı
                ),
              ),
            ),
            if (m.loading)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _SkeletonGrid extends StatelessWidget {
  const _SkeletonGrid();
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 2/3,
      ),
      itemBuilder: (_, __) => Container(
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(16)),
      ),
      itemCount: 6,
    );
  }
}
