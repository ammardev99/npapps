// class ServicesStatusController {
  // static final Map<String, bool> _status = {};
// 
  // static void setStatus(String service, bool connected) {
    // _status[service] = connected;
  // }
// 
  // static bool isConnected(String service) {
    // return _status[service] ?? false;
  // }
// 
  // static Map<String, bool> get all => Map.unmodifiable(_status);
// }

// ServicesStatusController.setStatus('Firebase', true);
// If you want, next I can
// Add retry + timeout
// Add dev vs prod toggle
// Add graceful app start even if Firebase fails