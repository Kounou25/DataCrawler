import 'package:flutter/material.dart';
import 'package:usage_stats/usage_stats.dart';

class UsageData extends StatelessWidget {
  Future<List<UsageInfo>> _fetchUsageStats() async {
    DateTime endDate = DateTime.now();
    DateTime startDate =
        DateTime.now().subtract(Duration(hours: 72)); // Dernières 24 heures

    try {
      // Récupère les statistiques d'utilisation
      List<UsageInfo> stats =
          await UsageStats.queryUsageStats(startDate, endDate);
      return stats;
    } catch (e) {
      print('Erreur : $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<UsageInfo>>(
        future: _fetchUsageStats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Afficher un loader en attendant
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Erreur : ${snapshot.error}')); // Afficher une erreur si elle survient
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
                    'Aucune donnée disponible')); // Si aucune donnée n'est disponible
          }

          // Si les données sont disponibles, les afficher dans une liste
          List<UsageInfo> usageStats = snapshot.data!;
          return ListView.builder(
            itemCount: usageStats.length,
            itemBuilder: (context, index) {
              UsageInfo info = usageStats[index];
              return ListTile(
                title: Text(info.packageName ?? 'App inconnue'),
                subtitle: Text('Dernière utilisation : ${info.lastTimeUsed}'),
                trailing: Text(
                    'Durée d\'utilisation : ${info.totalTimeInForeground ?? 0} ms'),
              );
            },
          );
        },
      ),
    );
  }
}
