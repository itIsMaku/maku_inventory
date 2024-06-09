VehicleClasses = {
    COMPACTS = 0,
    SEDANS = 1,
    SUVS = 2,
    COUPES = 3,
    MUSCLE = 4,
    SPORTS_CLASSICS = 5,
    SPORTS = 6,
    SUPER = 7,
    MOTORCYCLES = 8,
    OFF_ROAD = 9,
    INDUSTRIAL = 10,
    UTILITY = 11,
    VANS = 12,
    CYCLES = 13,
    BOATS = 14,
    HELICOPTERS = 15,
    PLANES = 16,
    SERVICE = 17,
    EMERGENCY = 18,
    MILITARY = 19,
    COMMERCIAL = 20,
    TRAINS = 21,
    OPEN_WHEEL = 22
}

return {
    trunk = {
        base = {
            maxWeight = 1000
        },
        classes = {
            [VehicleClasses.SPORTS] = {
                maxWeight = 5000
            },
            [VehicleClasses.SUPER] = {
                maxWeight = 6000
            },
        },
        models = {
            [`sultan2`] = {
                maxWeight = 2500
            },
        }
    },
    glovebox = {
        base = {
            maxWeight = 1000
        },
        classes = {
            [VehicleClasses.SPORTS] = {
                maxWeight = 5000
            },
            [VehicleClasses.SUPER] = {
                maxWeight = 6000
            },
        },
        models = {
            [`sultan2`] = {
                maxWeight = 2500
            },
        }
    }
}
