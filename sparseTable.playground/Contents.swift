
import UIKit


class SparseTable{
    var lookup: [[Int]]
    init(scores: [Int]) {
        lookup = [[Int]]()
        buildSparseTable(aux: scores)
        print(query(l: 0, r: 4))
        print(query(l: 4, r: 7))
        print(query(l: 7, r: 8))
    }
    func buildSparseTable(aux:[Int]) -> Void{
        for index in 0...aux.count-1{
            let local = Array(repeating: 0, count: 500)
            lookup.append(local)
            lookup[index][0]=aux[index]
        }
        var j = 1
        while (1 << j) <= aux.count {
            var i = 0
            while ((i + (1 << j))-1) < aux.count {
                let mn = lookup[i+(1<<(j-1))][j-1]
                if ( lookup[i][j-1] < mn ){
                    lookup[i][j] = lookup[i][j-1]
                }else{
                    lookup[i][j] = lookup[i + (1 << (j - 1))][j-1]
                }
                i+=1
            }
            j+=1
        }
    }
    func query( l: Int?, r: Int?) -> Int {
        let valueOne = Float(l!)
        let valueTwo = Float(r!)
        let j = log2(valueTwo - valueOne + 1)
        let complex = r!-(1 << Int(j)) + 1
        if (lookup[l!][Int(j)] <= lookup[complex][Int(j)]){
            return lookup[l!][Int(j)];
        }else{
            return lookup[r!-(1 << Int(j)) + 1][Int(j)];
        }
    }
}
