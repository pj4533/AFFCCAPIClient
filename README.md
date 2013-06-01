# AFFCCAPIClient

An AFHTTPClient subclass for the [FCC API](http://www.fcc.gov/developers).

Primary purpose right now is using the [census block conversions](http://www.fcc.gov/developers/census-block-conversions-api) API for an easy way to get FIPS numbers from GPS coordinates.

## Usage

``` objective-c
[[AFFCCAPIClient sharedClient] getFIPSWithLat:@"42.343653" withLng:@"-71.097701" success:^(AFHTTPRequestOperation *operation, id responseObject) {

    NSLog(@"FIPS Dictionary: %@", responseObject);
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
}];
```

## Contact

PJ Gray

- http://github.com/pj4533
- http://twitter.com/pj4533
- pj@pj4533.com

## License

AFFCCAPIClient is available under the MIT license. See the LICENSE file for more info.

