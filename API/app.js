var express = require("express");
var mysql = require('mysql');
var cors = require('cors');
var app = express();
var [ getDbConnection, executeOnDBWithPromise, executeProcedureOnDBWithPromise ] = require('./getDBConnection');



app.use(express.json()) // for parsing application/json
app.use(cors({
    origin: 'http://localhost:8080'
  }));
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

app.listen(3000, () => {
 console.log("Server running on port 3000");
});

const showAccountHistory = (req, res, next) => {
    try{
        var connection = mysql.createConnection({
            host: 'localhost',
            port: 3306,
            user: 'root',
            password: '',
            database: 'Mobike'
        });
        
        connection.connect();
        try{
            connection.query('SELECT * from AccountHistory where customer_id = 1 ORDER BY updated_timestamp_as_unix_epoch DESC LIMIT 0,10', function (err, rows, fields) {
                if (err) throw err
                res.json({
                    "status":"ok",
                    "result": [...rows],
                    "count":rows.length
                });
            });
        }catch{

        }finally{
            connection.end();
        }
        
        
    }
    catch{
        res.json({
            "status":"error",
            "reason": "Could not connect to Mysql"
        })
    }    
    return res;
}

const showMoveRequests = (req, res, next) => {
    try{
        var connection = mysql.createConnection({
            host: 'localhost',
            port: 3306,
            user: 'root',
            database: 'Mobike'
        });
        
        connection.connect();
        try{
            connection.query("SELECT \
                                MR.*, \
                                Concat(CM.first_name, ' ,' ,CM.last_name) as moderator_name \
                             FROM \
                                MoveRequest MR \
                            INNER JOIN ContentModerator CM USING (moderator_id) \
                            LIMIT 0,10", function (err, rows, fields) {
                if (err) throw err
                res.json({
                    "status":"ok",
                    "result": [...rows],
                    "count":rows.length
                });
            });
        }catch{

        }finally{
            connection.end();
        }
        
        
    }
    catch{
        res.json({
            "status":"error",
            "reason": "Could not connect to Mysql"
        })
    }    
    return res;
}

const showBikesAdded = (req, res, next) => {
    try{
        var connection = mysql.createConnection({
            host: 'localhost',
            port: 3306,
            user: 'root',
            database: 'Mobike'
        });
        
        connection.connect();
        try{
            connection.query(" \
                SELECT \
                    B.bicycle_id, \
                    B.added_at_timestamp added_at, \
                    Concat(CM.first_name, ' ,' ,CM.last_name) as moderator_name \
                FROM \
                    Bicycle B \
                    INNER JOIN ContentModerator CM USING (moderator_id) \
                WHERE CM.moderator_id = 1 \
                LIMIT 0,10", function (err, rows, fields) {
                if (err) throw err
                res.json({
                    "status":"ok",
                    "result": [...rows],
                    "count":rows.length
                });
            });
        }catch{

        }finally{
            connection.end();
        }
        
        
    }
    catch{
        res.json({
            "status":"error",
            "reason": "Could not connect to Mysql"
        })
    }    
    return res;
}

const showPrepaidPlans = (req, res, next) => {
    try{
        var connection = mysql.createConnection({
            host: 'localhost',
            port: 3306,
            user: 'root',
            database: 'Mobike'
        });
        
        connection.connect();
        try{
            connection.query(" \
                SELECT \
                    PP.plan_id, \
                    PP.plan_name, \
                    PP.cost, \
                    PP.valid_in_city, \
                    Concat(CM.first_name, ' ,' ,CM.last_name) as moderator_name \
                FROM \
                    PrepaidPlan PP \
                    INNER JOIN ContentModerator CM USING (moderator_id) \
                WHERE \
                    CM.moderator_id = 1 \
                LIMIT 0,10", function (err, rows, fields) {
                if (err) throw err
                res.json({
                    "status":"ok",
                    "result": [...rows],
                    "count":rows.length
                });
            });
        }catch{

        }finally{
            connection.end();
        }
        
        
    }
    catch{
        res.json({
            "status":"error",
            "reason": "Could not connect to Mysql"
        })
    }    
    return res;
}

const showBicycles = (req, res, next) => {
    try{
        var connection = mysql.createConnection({
            host: 'localhost',
            port: 3306,
            user: 'root',
            database: 'mobike'
        });
        
        connection.connect();
        try{
            connection.query("select Bicycle.* from Bicycle , Customer where Customer.city = Bicycle.city and Customer.customer_id=1", function (err, rows, fields) {
                if (err) throw err
                res.json({
                    "status":"ok",
                    "result": [...rows],
                    "count":rows.length
                });
            });
        }catch{

        }finally{
            connection.end();
        }
        
        
    }
    catch{
        res.json({
            "status":"error",
            "reason": "Could not connect to Mysql"
        })
    }    
    return res;
}

const showDamageReports = (req, res, next) => {
    try{
        var connection = mysql.createConnection({
            host: 'localhost',
            port: 3306,
            user: 'root',
            database: 'mobike'
        });
        
        connection.connect();
        try{
            connection.query('SELECT * from DamageReport', function (err, rows, fields) {
                if (err) throw err
                res.json({
                    "status":"ok",
                    "result": [...rows],
                    "count":rows.length
                });
            });
        }catch{

        }finally{
            connection.end();
        }
        
        
    }
    catch{
        res.json({
            "status":"error",
            "reason": "Could not connect to Mysql"
        })
    }    
    return res;
}

const findBikes = async (req, res, next) => {
    let connection = getDbConnection();
    // check courses created by this professor's id

    let latitude = req.body.latitude || 0.00;
    let longitude = req.body.longitude || 0.00;
    console.log("POST /bicycles/find body:");
    console.log(req.body);

    try{
        let findBikesQuery = "CALL FindBikesWithinNMilesOfLatLong(?)"
        let findBikesQueryIdentifiers = ['latitude', 'longitude']
        let findBikesQueryValues = [ latitude, longitude , 20]
        let findBikesQuerySql = mysql.format(findBikesQuery, [findBikesQueryValues])
        console.log("findBikesQuerySql");
        console.log(findBikesQuerySql);
        let findBikesQueryResults = await executeProcedureOnDBWithPromise(connection, findBikesQuerySql )
        if (findBikesQueryResults.rows && findBikesQueryResults.rows.length > 0){
            return res.status(200).json({
                status:"ok",
                "result": findBikesQueryResults.rows,
                "count": findBikesQueryResults.rows.length
            })
        }else{
            return res.status(200).json({
                status:"ok",
                "result":[],
                "count":0
            })
        }
    }catch(error){
        return res.status(500).json({
            status: "error",
            error: error.message,
            "errorFull": JSON.stringify(error),
            "errorCode": "GCP1SQE"
        })
    }finally{
        if (connection && connection.end) connection.end()
    }
}

const showBikesInCity = async (req, res, next) => {
    let connection = getDbConnection();
    // check courses created by this professor's id

    let city = req.body.city || 'CLT';
    console.log("POST /bicycles/city/show body:");
    console.log(req.body);

    try{
        let findBikesQuery = "CALL ShowBikesInCity(?)"
        let findBikesQueryValues = [ city ]
        let findBikesQuerySql = mysql.format(findBikesQuery, [findBikesQueryValues])
        console.log("findBikesQuerySql");
        console.log(findBikesQuerySql);
        let findBikesQueryResults = await executeProcedureOnDBWithPromise(connection, findBikesQuerySql )
        if (findBikesQueryResults.rows && findBikesQueryResults.rows.length > 0){
            return res.status(200).json({
                status:"ok",
                "result": findBikesQueryResults.rows,
                "count": findBikesQueryResults.rows.length
            })
        }else{
            return res.status(200).json({
                status:"ok",
                "result":[],
                "count":0
            })
        }
    }catch(error){
        return res.status(500).json({
            status: "error",
            error: error.message,
            "errorFull": JSON.stringify(error),
            "errorCode": "GCP1SQE"
        })
    }finally{
        if (connection && connection.end) connection.end()
    }
}

const findBikesInCityByStatus = async(req, res, next) => {
    let connection = getDbConnection();
    // check courses created by this professor's id

    let city = req.body.city || 'CLT';
    let status = req.body.status || 'available';
    
    console.log("POST /bicycles/find/status body:");
    console.log(req.body);

    try{
        let findBikesQuery = "CALL ShowStatusBikesInCity(?)"
        let findBikesQueryValues = [ status , city ]
        let findBikesQuerySql = mysql.format(findBikesQuery, [findBikesQueryValues])
        console.log("findBikesQuerySql");
        console.log(findBikesQuerySql);
        let findBikesQueryResults = await executeProcedureOnDBWithPromise(connection, findBikesQuerySql )
        if (findBikesQueryResults.rows && findBikesQueryResults.rows.length > 0){
            return res.status(200).json({
                status:"ok",
                "result": findBikesQueryResults.rows,
                "count": findBikesQueryResults.rows.length
            })
        }else{
            return res.status(200).json({
                status:"ok",
                "result":[],
                "count":0
            })
        }
    }catch(error){
        return res.status(500).json({
            status: "error",
            error: error.message,
            "errorFull": JSON.stringify(error),
            "errorCode": "GCP1SQE"
        })
    }finally{
        if (connection && connection.end) connection.end()
    }
}

const showCityRides = async (req, res, next) => {
    let connection = getDbConnection();
    // check courses created by this professor's id

    let city = req.body.city || 'CLT';
    
    console.log("POST /rides/city/show");
    console.log(req.body);

    try{
        let findOngoingRidesQuery = "CALL ShowOngoingRidesInCity(?)"
        let findFinishedRidesQuery = "CALL ShowFinishedRideInCity(?)"
        let findRidesQueryValues = [ city ]
        let findOngoingRidesQuerySql = mysql.format(findOngoingRidesQuery, [findRidesQueryValues]);
        let findFinishedRidesQuerySql = mysql.format(findFinishedRidesQuery, [findRidesQueryValues]);
        console.log("findOngoingRidesQuerySql");
        console.log(findOngoingRidesQuerySql);
        
        console.log("findFinishedRidesQuerySql");
        console.log(findFinishedRidesQuerySql);

        let findOngoingRidesResults = await executeProcedureOnDBWithPromise(connection, findOngoingRidesQuerySql );
        let findFinishedRidesResults = await executeProcedureOnDBWithPromise(connection, findFinishedRidesQuerySql );

        console.log("findOngoingRidesResults", findOngoingRidesResults);
        console.log("findFinishedRidesResults", findFinishedRidesResults);

        if (findOngoingRidesResults.rows && findOngoingRidesResults.rows.length > -1 && findFinishedRidesResults.rows && findFinishedRidesResults.rows.length > -1){
            return res.status(200).json({
                status:"ok",
                "result": {
                    ongoing: findOngoingRidesResults.rows,
                    finished: findFinishedRidesResults.rows
                },
                "count": findOngoingRidesResults.rows.length + findFinishedRidesResults.rows.length
            })
        }else{
            return res.status(200).json({
                status:"ok",
                "result":[],
                "count":0
            })
        }
    }catch(error){
        return res.status(500).json({
            status: "error",
            error: error.message,
            "errorFull": JSON.stringify(error),
            "errorCode": "GCP1SQE"
        })
    }finally{
        if (connection && connection.end) connection.end()
    }
}

const startRide = async (req, res, next) => {
    let connection = getDbConnection();

    let customerId = parseInt(req.body.customer_id);
    let bicycleId = parseInt(req.body.bicycle_id);
    let started = false
    
    console.log("POST /rides/city/ride/start");
    console.log(req.body);

    try{
        let startRideQuery = "CALL StartRide(?);"
        let startRideQueryValues = [ bicycleId , customerId ]

        let startRideQuerySql = mysql.format(startRideQuery, [startRideQueryValues]);
        console.log("startRideQuerySql");
        console.log(startRideQuerySql);

        let startRideQuerySqlResults = await executeProcedureOnDBWithPromise(connection, startRideQuerySql );
        console.log("startRideQuerySqlResults", startRideQuerySqlResults);

        if (startRideQuerySqlResults.rows && startRideQuerySqlResults.rows.length > -1){
            return res.status(200).json({
                status:"ok",
                action: "started"
            })
        }else{
            return res.status(200).json({
                status:"ok",
                action: "error",
                "count":0
            })
        }
    }catch(error){
        return res.status(500).json({
            status: "error",
            action: "error",
            error: error.message,
            "errorFull": JSON.stringify(error),
            "errorCode": "GCP1SQE"
        })
    }finally{
        if (connection && connection.end) connection.end()
    }
}

const endRide = async (req, res, next) => {
    let connection = getDbConnection();
    console.log("called endride endpoint");


    let rideId = parseInt(req.body.ride_id);
    let location_name = req.body.loc_name;
    let location_lat = parseFloat(req.body.loc_lat);
    let location_long = parseFloat(req.body.loc_long);
    
    console.log("POST /rides/city/ride/end");
    console.log(req.body);

    try{
        let endRideQuery = "CALL EndRideWithoutOut(?);"
        let endRideQueryValues = [ location_name , location_lat, location_long, rideId ]

        let endRideQuerySql = mysql.format(endRideQuery, [endRideQueryValues]);
        console.log("endRideQuerySql");
        console.log(endRideQuerySql);

        let endRideQuerySqlResults = await executeProcedureOnDBWithPromise(connection, endRideQuerySql );
        console.log("endRideQuerySqlResults", endRideQuerySqlResults);

        if (endRideQuerySqlResults.rows && endRideQuerySqlResults.rows.length > -1){
            return res.status(200).json({
                status:"ok",
                action: "ended"
            })
        }else{
            return res.status(200).json({
                status:"ok",
                action: "error",
                "count":0
            })
        }
    }catch(error){
        return res.status(500).json({
            status: "error",
            action: "error",
            error: error.message,
            "errorFull": JSON.stringify(error),
            "errorCode": "GCP1SQE"
        })
    }finally{
        if (connection && connection.end) connection.end()
    }
}

app.get("/accounthistory", showAccountHistory);
app.get("/bicycles", showBicycles);
app.get("/damagereports", showDamageReports);
app.get("/moverequests", showMoveRequests);
app.get("/bikesadded", showBikesAdded);
app.get("/showaddedplans", showPrepaidPlans);

app.post("/bicycles/find", findBikes);
app.post("/bicycles/find/status", findBikesInCityByStatus);
app.post("/bicycles/city/show", showBikesInCity);
app.post("/rides/city/show", showCityRides);
app.post("/rides/city/start", startRide);
app.post("/rides/city/end", endRide);
