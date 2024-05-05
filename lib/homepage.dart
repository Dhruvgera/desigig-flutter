import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worker Homepage'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigate to home screen
              },
            ),
            ListTile(
              title: Text('Jobs'),
              onTap: () {
                // Navigate to jobs screen
              },
            ),
            ListTile(
              title: Text('Accounts'),
              onTap: () {
                // Navigate to accounts screen
              },
            ),
            ListTile(
              title: Text('Tax'),
              onTap: () {
                // Navigate to tax screen
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      'http://dummyimage.com/512x512.png/cc0000/ffffff',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome Username',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: jobList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(jobList[index]['companyURL']),
                    ),
                    title: Text(jobList[index]['jobTitle']),
                    subtitle: Text(jobList[index]['salary']),
                    trailing: Text(jobList[index]['freq']),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> jobList = [
  {
    "id": 89,
    "jobId": "z01234-5678-90ab-cdef-ghij",
    "jobTitle": "House Painter (घर का पेंटर)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Paint It Right",
    "salary": "₹600 per day",
    "freq": "daily",
    "jobType": "temporary",
    "duration": 0,
    "geoLong": "77.21672100000000000000",
    "geoLat": "28.64480000000000000000",
    "distance": 8
  },
  {
    "id": 88,
    "jobId": "y90123-4567-890a-bcde-fghi",
    "jobTitle": "Security Guard (सुरक्षा गार्ड)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Secure India Security Services",
    "salary": "₹500 per day",
    "freq": "daily",
    "jobType": "temporary",
    "duration": 9,
    "geoLong": "77.21672100000000000000",
    "geoLat": "28.64480000000000000000",
    "distance": 8
  },
  {
    "id": 87,
    "jobId": "x89012-cdef-ghij-klmn-opqr",
    "jobTitle": "Housekeeper (घर की देखभाल करने वाला)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Mrs. Kapoor",
    "salary": "₹400 per day",
    "freq": "daily",
    "jobType": "temporary",
    "duration": 12,
    "geoLong": "77.21672100000000000000",
    "geoLat": "28.64480000000000000000",
    "distance": 8
  },
  {
    "id": 86,
    "jobId": "w78901-bcde-fghi-jklm-nopq",
    "jobTitle": "Maid (मेड)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Mrs. Sharma",
    "salary": "₹300 per day",
    "freq": "daily",
    "jobType": "temporary",
    "duration": 6,
    "geoLong": "77.21672100000000000000",
    "geoLat": "28.64480000000000000000",
    "distance": 8
  },
  {
    "id": 85,
    "jobId": "v67890-abcd-efgh-ijkl-mnop",
    "jobTitle": "Street Sweeper (सड़क सफाई कर्मचारी)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Clean India Initiative",
    "salary": "₹200 per day",
    "freq": "daily",
    "jobType": "temporary",
    "duration": 8,
    "geoLong": "77.21672100000000000000",
    "geoLat": "28.64480000000000000000",
    "distance": 8
  },
  {
    "id": 84,
    "jobId": "u56789-0abc-defg-hijk-lmno",
    "jobTitle": "Tea Stall Vendor (चाय ठेला विक्रेता)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Chai Wala",
    "salary": "₹100 per hour",
    "freq": "hourly",
    "jobType": "temporary",
    "duration": 10,
    "geoLong": "77.21672100000000000000",
    "geoLat": "28.64480000000000000000",
    "distance": 8
  },
  {
    "id": 83,
    "jobId": "t45678-90ab-cdef-ghij-klmn",
    "jobTitle": "Event Photographer (इवेंट फोटोग्राफर)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Capture the Moment Photography",
    "salary": "₹800 per event",
    "freq": "per event",
    "jobType": "temporary",
    "duration": 4,
    "geoLong": "77.78901200000000000000",
    "geoLat": "28.95678900000000000000",
    "distance": 23
  },
  {
    "id": 82,
    "jobId": "s34567-890a-bcde-fghi-jklm",
    "jobTitle": "Tutor (ट्यूटर)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Smart Learning Academy",
    "salary": "₹500 per hour",
    "freq": "hourly",
    "jobType": "temporary",
    "duration": 2,
    "geoLong": "77.67890100000000000000",
    "geoLat": "28.84567800000000000000",
    "distance": 15
  },
  {
    "id": 81,
    "jobId": "r23456-7890-abcd-efgh-ijkl",
    "jobTitle": "Gardener (माली)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Green Thumb Landscaping",
    "salary": "₹300 per day",
    "freq": "daily",
    "jobType": "temporary",
    "duration": 5,
    "geoLong": "77.56789000000000000000",
    "geoLat": "28.73456700000000000000",
    "distance": 8
  },
  {
    "id": 80,
    "jobId": "q12345-6789-0abc-defg-hijk",
    "jobTitle": "Pet Sitter (पालतू जानवरों की देखभालक)",
    "companyURL": "http://dummyimage.com/512x512.png/cc0000/ffffff",
    "company": "Pawsome Pet Care",
    "salary": "₹200 per hour",
    "freq": "hourly",
    "jobType": "temporary",
    "duration": 3,
    "geoLong": "77.45678900000000000000",
    "geoLat": "28.62345600000000000000",
    "distance": 2
  }
];
