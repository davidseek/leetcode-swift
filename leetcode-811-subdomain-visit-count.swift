/**

Copyright (c) 2020 David Seek, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
OR OTHER DEALINGS IN THE SOFTWARE.





https://leetcode.com/problems/subdomain-visit-count/


A website domain like "discuss.leetcode.com" consists of various subdomains. At the top level, we have "com", at the next level, we have "leetcode.com", and at the lowest level, "discuss.leetcode.com". When we visit a domain like "discuss.leetcode.com", we will also visit the parent domains "leetcode.com" and "com" implicitly.

Now, call a "count-paired domain" to be a count (representing the number of visits this domain received), followed by a space, followed by the address. An example of a count-paired domain might be "9001 discuss.leetcode.com".

We are given a list cpdomains of count-paired domains. We would like a list of count-paired domains, (in the same format as the input, and in any order), that explicitly counts the number of visits to each subdomain.

Example 1:
Input: 
["9001 discuss.leetcode.com"]
Output: 
["9001 discuss.leetcode.com", "9001 leetcode.com", "9001 com"]
Explanation: 
We only have one website domain: "discuss.leetcode.com". As discussed above, the subdomain "leetcode.com" and "com" will also be visited. So they will all be visited 9001 times.

Example 2:
Input: 
["900 google.mail.com", "50 yahoo.com", "1 intel.mail.com", "5 wiki.org"]
Output: 
["901 mail.com","50 yahoo.com","900 google.mail.com","5 wiki.org","5 org","1 intel.mail.com","951 com"]
Explanation: 
We will visit "google.mail.com" 900 times, "yahoo.com" 50 times, "intel.mail.com" once and "wiki.org" 5 times. For the subdomains, we will visit "mail.com" 900 + 1 = 901 times, "com" 900 + 50 + 1 = 951 times, and "org" 5 times.

Notes:

The length of cpdomains will not exceed 100. 
The length of each domain name will not exceed 100.
Each address will have either 1 or 2 "." characters.
The input count in any count-paired domain will not exceed 10000.
The answer output can be returned in any order.

*/

/**
Big O Annotation
Time complexity O(n) where n is the amount of elements in nums.
Space complexity O(n) where n is the amount of elements in nums.
*/
func subdomainVisits(_ cpdomains: [String]) -> [String] {
        
    let domainsMap = getMapping(for: cpdomains)
    return getUnsortedVisitCount(forMappedDomains: domainsMap)
}

/**
- Parameters: 
    - domainsMap: A dictionary of domains and their visit counts

- returns: 
An unsorted array of domains and their visit counts in the format: "[count] [domain]"

- Important:
Time complexity is O(n) where n is the number of elements in domainsMap
*/
private func getUnsortedVisitCount(forMappedDomains domainsMap: [String: Int]) -> [String] {
    
    var output: [String] = []
    
    for (key, value) in domainsMap {
        output.append("\(value) \(key)")
    }
    
    return output
}

/**
- Parameters: 
    - cpdomains: An array of domain visits in the format: "[count] [domain]"

- returns: 
A dictionary of key: String (domain name) and value: Integer (visit count)

- Important:
Time complexity is O(n) where n is the number of elements in cpdomains
*/
private func getMapping(for cpdomains: [String]) -> [String: Int] {
    
    var map: [String: Int] = [:]
    
    for cpdomain in cpdomains {
        
        /**
        First separate the visit count from the domain
        example before: "1001 davidseek.com"
        example after: ["1001", "davidseek.com"]
        */
        let components = cpdomain.components(separatedBy: " ")

        /**
        Get an integer from the visit count.
        We're forcing the conversion as stated in the 
        description that it is guaranteed to be valid.
        */
        let counter = Int(components[0])!

        // Next we get the current domain
        let fullDomain = components[1]

        // ... and split it by the dots
        let subDomains = fullDomain.components(separatedBy: ".")
        
        /**
        Now we want to add first the full domain
        for example "discuss.leetcode.com"
        */
        var domains: [String] = [fullDomain]
        
        /**
        The problem notes did state that we have at most 
        3 components ("Each address will have either 1 or 2 "." characters.")
        Therefore we have either 2 or 3 subDomains.
        */
        if subDomains.count == 3 {
            
            /**
            If so, we now get the parent.
            For example for "discuss.leetcode.com"
            we now have ["leetcode", "com"]
            */
            let parentDomainComponents: [String] = Array(subDomains[1...2])

            // And we join them back together to get "leetcode.com"
            let parentDomain = parentDomainComponents.joined(separator: ".")
            
            // We add "leetcode.com"
            domains.append(parentDomain)
            
            // And we add just the "com"
            domains.append(subDomains[2])
            
        // leetcode.com
        } else {
            
            /**
            If we have less than 3 parts, our starting domain is
            for example "leetcode.com" and since we've already added
            the full domain, we now just need to add the "com"
            */
            domains.append(subDomains[1])
        }
        
        /**
        Lastly we need to iterate through our
        2-3 domains and adjust their counter.

        This operation still leaves us with
        a linear parent loop as the worst case,
        O(n * 3) has a constant and we're dropping 
        the constant to get O(n)
        */
        for domain in domains {
            
            // Check if the domain exists in the map
            if let mapped = map[domain] {

                // ... if so update the counter
                map[domain] = mapped + counter
            } else {

                // ... if not, add the counter
                map[domain] = counter
            }
        }
    }
    
    return map
}