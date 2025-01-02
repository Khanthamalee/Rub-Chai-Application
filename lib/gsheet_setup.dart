import 'package:gsheets/gsheets.dart';

var sheetid = "1bllpJ3tb23y8xCfJTEG9tGIBfIMarbbTSIeYDbikNNg";
var credentials = r'''{
"type": "service_account",
  "project_id": "finance-crud-gsheet-to-flutter",
  "private_key_id": "46130d575bcfda328202fd3efd8f37ceb862e18a",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQC3j9u/hjawKfyp\nF2k5CYyzDR4BVuT6BEhZ7GFi7UPHOtonBB/haJKNWAGm5tro2Qjop3HJBzIZCjRH\nIiT/Vol5rExvdprP7QS+hw8AbbP+WWl3fY87Yz0MYVlPKBpUHrLUWqBosdtj9psi\nn6SuOe2TO95fFbPNUQQD/8AVgW/8Q7qvz4mPGYh8NNmB5N218jTCu3bsSkqowbK4\n0zQEE7mZcADEcmpLt1jcaerllhvSMR70X/qoa4VF9z+VHB98a6rwrtBHkX8wyLlA\n3vn+qpF5BrGC8BvbOS1kl+2We8Vi5g3Yo6hFrirJmLdXsQNcU48u0pUCC/t9Ojfh\neaHAQfzxAgMBAAECgf9PdKXaMW5astH7H3cciVWt62+hhMt4rYHj6r385FcCVic3\n3EEwgONu6zlL1YHMaKXCjzhhnAvDavdWEyGQpRS85ifv15cLib0T+8IynUncPze3\n0VG+kyZJxZmy+djrsJ4X7WKh7trYWlaslg3inJCJutB2uB4sMXVbhcjPhkfDGZHh\n3do89ydni9KA4QhYxgBIE8xvqNNTMLvLLw4DeR2KjVQ9ARA7DQSDQhcXBjpMJK76\naDEFpPPAth6PWAYiGBH1FjjXg0J7NiNRGrajVS/992VnJCUf0kUlRRr9Lzw0XLRE\nDB1J8ZU+FDqyzyi6KgRyr8IJeS6I6IOlCq2EJ4ECgYEA6sSnR0uf98JMFwUGEZVa\nNXO94CfaG3L2UIzt7oqtBrePkXgPn8ypnIL6kigtKsoNhuUq5KvLDLG99FMdk1mY\nR+O7aTqqC1hrCGRPZyoksXnlU1BhYG2k0rDapQO77yUui5vg1b0oztQu00G/Gkuo\nzIz9JzeCcrn7gk97/7H/DoECgYEAyCmt/1B1DMRroQT/DpoJ+21rbXDvOA3DKZuy\nzAVkqw1iQCJ3LLcZ3kcutjiY3c6Jk3J7TLq7YwOaL1dy3+8mqYmg1M5GXqJJfWTh\nhB7GrNrSgG4/fy60OCAVEa9j693oO+ng/MjIpsE0Pmi8GA0tTLJmfwjPx2iBcpil\n0m+tlnECgYBmveNbLzx1yEFWfatXPJ568AkztR0dkCU9wT9LesMYQnMBPaLQ01eT\nGDsihZSmukBLPbWU154IEy1HZKx31Ojw5TgaaEMMrghBZuzdADOIvAjhejbzZWiR\nkDZPqx+vG/2PuYse3yahxXgsmgRRNLVNt5H+fKuJG912/OQOVc6CgQKBgGHZrkvP\n40i4hP0UWjOjLhoRpaC8wtUeNTgT+1YtlMbiJhPARY5AfI7jMXy3MlPMcgj4wDoE\nVzLSQf++ulOqr7XVqCAgLtp4b4CzXmOeP/Wki59pRfVAua1uUZ5xpWFa+/q+HNS2\nuxB6BrYzsS/40RpbZCvZ/Ok4t390DCxRmAShAoGBANimN0h2NUI0HYcxWkUGMEXt\nzKXWqimSJ+BsKiTMLiFhRGIOWK0UN+WnqMGH0X9e3tN6MPO72YF2JrSDr24DSX64\nSXnjx5oUhdcR7pJqsLx7mKGGmdHsR1exUU7w/qnVLmd/iOflquboxUdnCcldCRKm\nzlE/o9g93DsdQZDJd1hW\n-----END PRIVATE KEY-----\n",
  "client_email": "finance-crud-gsheet-to-flutter@finance-crud-gsheet-to-flutter.iam.gserviceaccount.com",
  "client_id": "103506356155397800890",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/finance-crud-gsheet-to-flutter%40finance-crud-gsheet-to-flutter.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  }''';

final gsheets = GSheets(credentials);
var GsheetController;
Worksheet? GsheetCRUDUserDetails;

GSheetsinit() async {
  GsheetController = await gsheets.spreadsheet(sheetid);
  GsheetCRUDUserDetails =
      await GsheetController.worksheetByTitle("27/11-27/12");
}



