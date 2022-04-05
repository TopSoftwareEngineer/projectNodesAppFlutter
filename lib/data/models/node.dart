class Node {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String walletAddress;
  final int dateCreated;
  final String name;
  final String rpcUrl;
  final String wssUrl;
  final int maintenancefeeLastpaid;
  final String network;
  final String location;
  final String status;
  final String valueInitials;

  const Node({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.walletAddress,
    required this.dateCreated,
    required this.rpcUrl,
    required this.wssUrl,
    required this.maintenancefeeLastpaid,
    required this.network,
    required this.location,
    required this.name,
    required this.status,
    required this.valueInitials,
  });

  factory Node.fromMap(Map map) {
    return Node(
      id: map['id'],
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      deletedAt: map['deleted_at']?? '',
      walletAddress: map['wallet_address'],
      dateCreated: map['date_created'],
      rpcUrl: map['rpc_url'] ?? '',
      wssUrl: map['wss_url']?? '',
      maintenancefeeLastpaid: map['maintenancefee_lastpaid'],
      network: map['network']?? '',
      location: map['location']?? '',
      name: map['node_name']?? '',
      status: 'READY',
      valueInitials: '0.156',
    );
  }
}
