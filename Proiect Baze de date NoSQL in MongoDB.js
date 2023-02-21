use proiect

db.createCollection("useri")

db.useri.insertOne(
    {
        "nume": "Stroia",
        "prenume": "Iulian",
        "telefon": "0765187920",
        "dataNastere": new Date("2003-07-07"),
        "infoAbonament": {
            "tipAbonament": "minim",
            "tarif": 7.99,
            "nrDispozitive": 1,
            "dataFacturare": new Date()
        },
        "preferinte": ["Jumanji - Welcome to the jungle", "Narcos"]
    })

db.useri.insertMany([
    {
        "nume": "Marian",
        "prenume": "Andra",
        "telefon": "0749815007",
        "dataNastere": new Date("1999-03-22"),
        "infoAbonament": {
            "tipAbonament": "minim",
            "tarif": 7.99,
            "nrDispozitive": 1,
            "dataFacturare": new Date()
        },
        "preferinte": ["Alfie", "Ozark"]
    },
    {
        "nume": "Rotaru",
        "prenume": "Lavinia",
        "telefon": "0745971206",
        "dataNastere": new Date("1985-02-09"),
        "infoAbonament": {
            "tipAbonament": "minim",
            "tarif": 7.99,
            "nrDispozitive": 1,
            "dataFacturare": new Date()
        },
        "preferinte": ["The cabin in the woods", "Outlander"]
    },
    {
        "nume": "Ionita",
        "prenume": "Radu",
        "telefon": "0736541809",
        "dataNastere": new Date("2001-09-29"),
        "infoAbonament": {
            "tipAbonament": "premium",
            "tarif": 11.99,
            "nrDispozitive": 4,
            "dataFacturare": new Date()
        },
        "preferinte": ["Inception", "Outer Banks"]
    },
    {
        "nume": "Chirita",
        "prenume": "Octavian",
        "telefon": "0797844576",
        "dataNastere": new Date("1995-11-30"),
        "infoAbonament": {
            "tipAbonament": "premium",
            "tarif": 11.99,
            "nrDispozitive": 4,
            "dataFacturare": new Date()
        },
        "preferinte": ["Unfaithful", "Locked up"]
    },
    {
        "nume": "Ene",
        "prenume": "Maria",
        "telefon": "0734587692",
        "dataNastere": new Date("2000-04-21"),
        "infoAbonament": {
            "tipAbonament": "minim",
            "tarif": 7.99,
            "nrDispozitive": 1,
            "dataFacturare": new Date()
        },
        "preferinte": ["Do revenge", "The Good Place"]
    },
    {
        "nume": "Anghel",
        "prenume": "Ana-Maria",
        "telefon": "0749815007",
        "dataNastere": new Date("2000-08-01"),
        "infoAbonament": {
            "tipAbonament": "premium",
            "tarif": 11.99,
            "nrDispozitive": 4,
            "dataFacturare": new Date()
        },
        "preferinte": ["The Adam Project", "The Crown"]
    },
    {
        "nume": "Valeriu",
        "prenume": "Paul",
        "telefon": "0727945061",
        "dataNastere": new Date("1989-01-11"),
        "infoAbonament": {
            "tipAbonament": "standard",
            "tarif": 9.99,
            "nrDispozitive": 2,
            "dataFacturare": new Date()
        },
        "preferinte": ["The Pledge", "The Flash"]
    },
    {
        "nume": "Mihai",
        "prenume": "Gabriela",
        "telefon": "0778128451",
        "dataNastere": new Date("1994-12-15"),
        "infoAbonament": {
            "tipAbonament": "standard",
            "tarif": 9.99,
            "nrDispozitive": 2,
            "dataFacturare": new Date()
        },
        "preferinte": ["Enola Holmes", "Virgin River"]
    },
    {
        "nume": "Lorelai",
        "prenume": "Ancuta",
        "telefon": "0725486137",
        "dataNastere": new Date("1976-05-14"),
        "infoAbonament": {
            "tipAbonament": "standard",
            "tarif": 9.99,
            "nrDispozitive": 2,
            "dataFacturare": new Date()
        },
        "preferinte": ["Top Gun", "Unsolved mysteries"]
    }
])

db.useri.find({})

db.operatori.insertMany([
    {
        "nume": "Paraschiv",
        "prenume": "Marian", 
        "functie": "Specialist operational", 
        "dataAngajare": new Date("2021-04-13"),
        "salariul": 4750
    },
    {
        "nume": "Borca",
        "prenume": "Andreea", 
        "functie": "Director", 
        "dataAngajare": new Date("2016-09-21"),
        "salariul": 9420
    },
    {
        "nume": "Matei",
        "prenume": "Radu", 
        "functie": "Specialist operational", 
        "dataAngajare": new Date("2021-12-05"),
        "salariul": 3460
    },
    {
        "nume": "Oancea",
        "prenume": "Laura", 
        "functie": "Manager departament", 
        "dataAngajare": new Date("2019-07-30"),
        "salariul": 6280
    },
    {
        "nume": "Anton",
        "prenume": "Marius", 
        "functie": "Team leader", 
        "dataAngajare": new Date("2017-02-03"),
        "salariul": 7370
    },
    {
        "nume": "Trusca",
        "prenume": "Mara", 
        "functie": "Specialist operational", 
        "dataAngajare": new Date("2022-01-17"),
        "salariul": 4200
    },
    {
        "nume": "Popescu",
        "prenume": "Greta", 
        "functie": "Manager departament", 
        "dataAngajare": new Date("2020-08-10"),
        "salariul": 8150
    },
    {
        "nume": "Moraru",
        "prenume": "Bogdan", 
        "functie": "Team leader", 
        "dataAngajare": new Date("2018-02-18"),
        "salariul": 7400
    },
    {
        "nume": "Sandu",
        "prenume": "Flavius", 
        "functie": "Team leader", 
        "dataAngajare": new Date("2020-06-29"),
        "salariul": 5610
    },
    {
        "nume": "Narcu",
        "prenume": "Corina", 
        "functie": "Manager departament", 
        "dataAngajare": new Date("2018-11-06"),
        "salariul": 8330
    },
    {
        "nume": "Udreanu",
        "prenume": "Ancuta", 
        "functie": "Specialist operational", 
        "dataAngajare": new Date("2022-05-27"),
        "salariul": 4150
    }
    ])

db.operatori.find({})

db.useri.find({"infoAbonament.tipAbonament": "premium"})

db.useri.find({"_id": 0, "nume": 1, "prenume": 1, "infoAbonament.tipAbonament": 1, "infoAbonament.tarif": 1})

db.useri.find({"prenume": {$not: {$regex: /^A/}}}, "_id": 0, "nume": 1, "prenume": 1, "telefon": 1, "dataNastere": 1)

db.useri.find({$and: [{"infoAbonament.tipAbonament": "minim"}, {"dataNastere": {$gte: ISODate("1990-01-01"), $lte: ISODate("2000-12-31")}}]}, 
{"_id": 0, "nume": 1, "dataNastere": 1, "infoAbonament.tipAbonament": 1, "infoAbonament.tarif": 1})

db.operatori.find({$or: [{"functie": {$ne: "Specialist operational"}}, {"salariul": {$in: [8330, 9420]}}]}, 
{"_id": 0, "nume": 1, "functie": 1, "salariul": 1})

db.operatori.find({$and: [{"prenume": {$regex: /^M/}}, {"functie": {$eq: "Specialist operational"}}]).projection({"_id": 0, "dataAngajare": 0}).sort("salariul": -1)

db.operatori.find({"functie": "Team leader"}).count()


db.useri.updateOne({"nume": "Anghel"},{$set:{"telefon": "0720895112"}}

db.useri.find({"nume": "Anghel"}, {"_id": 0})

db.operatori.updateMany({"salariul": {$lt: 6000}}, {$mul: {"salariul": 5.2}})

db.operatori.find({}, {"_id": 0, "prenume": 0, "dataAngajare": 0})


db.useri.deleteOne({"dataNastere": {$eq: ISODate("2000-04-21")}})

db.operatori.deleteMany({"salariul": {$in: [7370, 7400]}})



db.operatori.aggregate([
    {
        $addFields: {
            "lunaAngajare": {$month: "$dataAngajare"}
        }
    },
    {
        $group: {
            "_id": "$functie",
            "salariulMediu": {$avg: "$salariul"}
        }
    },
    {
        $sort: {
            "salariulMediu": -1
        }
    }
    ])

db.operatori.aggregate([
    {
        $addFields: {
            "anAngajare": {$year: "$dataAngajare"}
        }
    },
    {
        $match: {
            "salariul": {$gt: 5000, $gt: 7000}
        }
    },
    {
        $group: {
            "_id": "$anAngajare",
            "salariulTotal": {$sum: "$salariul"}
        }
    },
    {
        $sort: {
            "_id": -1
        }
    }
    ])

db.useri.aggregate([
    {
        $match: {
            "infoAbonament.tipAbonament": "standard"
        }
    },
    {
        $group: {
            "_id": "$infoAbonament.tipAbonament",
            "nrAbonamente": {$sum: 1}
        }
    }
    ])

db.operatori.aggregate([
    {
        $addFields: {
            "numeComplet": {$concat: ["$nume", " ", "$prenume"]},
            "lunaAngajare": {$month: "$dataAngajare"},
            "anAngajare": {$year: "$dataAngajare"},
            "categorieSalariu": {
                $switch: {
                    branches: [
                            {case: {$lt: ["$salariul", 9000]}, then: "salariu minim"},
                            {case: {$lt: ["$salariul", 12000]}, then: "salariu mediu"},
                        ],
                        default: "salariu mare"
                }
            }
        }
    },
    {
        $group: {
            "_id": "$categorieSalariu",
            "nrAngajati": {$sum: 1}
        }
    }
    ])
    
db.useri.updateMany({"infoAbonament.tipAbonament": "minim"}, 
{$set: {"operator": [ObjectId("63775401e0fe513163dc9d3b"), ObjectId("63775401e0fe513163dc9d36"), ObjectId("63775401e0fe513163dc9d33"), 
ObjectId("63775401e0fe513163dc9d31")]}})
db.useri.updateMany({"infoAbonament.tipAbonament": "standard"}, 
{$set: {"operator": [ObjectId("63775401e0fe513163dc9d3a"), ObjectId("63775401e0fe513163dc9d37"), ObjectId("63775401e0fe513163dc9d34")]}})
db.useri.updateMany({"infoAbonament.tipAbonament": "premium"}, 
{$set: {"operator": [ObjectId("63775401e0fe513163dc9d39")]}})


db.useri.aggregate([
    {
        $lookup: {
            from: "operatori",
            localField: "operator",
            foreignField: "_id",
            as: "numeOperator"
        }
    }
    ])

db.operatori.aggregate([
    {
        $bucket: {
            groupBy: "$salariul",
            boundaries: [7000, 9000, 11000, 13000, 15000],
            default: "alta valoare", 
            output: {"Angajati": {$push: {Nume: "$nume", Prenume: "$prenume", Salariul: "$salariul"}}}
        }
    }
    ])










