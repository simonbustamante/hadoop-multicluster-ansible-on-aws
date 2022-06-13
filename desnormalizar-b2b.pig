/* cargando actividades */ 
activity = LOAD 'hdfs://master1.ansible.local:9000/b2b/activity/part-m-00000' USING PigStorage(',')
    AS (
        activity_id:chararray,
        name:chararray,
        description:chararray
    );

/* se ignora tabla admin y doctrine-migrations ya que no se analizarán datos de usuarios de la aplicación */

/* cargando productos solicitados a b2b desde b2c*/

b2_cproduct_request = LOAD 'hdfs://master1.ansible.local:9000/b2b/b2_cproduct_request/part-m-00000' USING PigStorage(',')
    AS (
        id:chararray,
        mayani_inventory_id:chararray,
        description:chararray,
        quantity_kg:chararray,
        total_debt:chararray,
        date:chararray
    );
/* cargando granjas */ 
farms = LOAD 'hdfs://master1.ansible.local:9000/b2b/farm/part-m-00000' USING PigStorage(',')
    AS (
        farm_id: chararray,
        farmer_id: chararray,
        location_id: chararray,
        farm_name: chararray
    );
/* cargando actividades de granjas */ 
farm_activity = LOAD 'hdfs://master1.ansible.local:9000/b2b/farm_activity/part-m-00000' USING PigStorage(',')
    AS (
        farm_id:chararray,
        activity_id:chararray
    );
/* cargando grupo de las granjas */
farm_group =  LOAD 'hdfs://master1.ansible.local:9000/b2b/farm_group/part-m-00000' USING PigStorage(',')
    AS (
        farm_id:chararray,
        group_id:chararray
    );
/* cargando inventario de granjas */   
farm_inventory = LOAD 'hdfs://master1.ansible.local:9000/b2b/farm_inventory/part-m-00000' USING PigStorage(',')
    AS (
        fi_id:chararray,
        farm_id:chararray,
        product_id:chararray,
        fi_date:chararray,
        fi_total_credit:chararray,
        fi_total_kg:chararray,
        fi_description:chararray
    );
/* cargando balance de los granjeros */ 
farmer_balance = LOAD 'hdfs://master1.ansible.local:9000/b2b/farmer_balance/part-m-00000' USING PigStorage(',')
    AS (
        id:chararray,
        farmer_id:chararray,
        total_debt:chararray,
        total_credit:chararray,
        total_monthly_fee:chararray,
        farmer_description:chararray
    );
/* cargando relacion many to many de balance de granjeros y prestamos */ 
farmer_balance_farmer_loans = LOAD 'hdfs://master1.ansible.local:9000/b2b/farmer_balance_farmer_loans/part-m-00000' USING PigStorage(',')
    AS (
        farmer_balance_id:chararray,
        farmer_loans_id:chararray
    );
/* cargando prestamos de granjeros */ 
farmer_loans = LOAD 'hdfs://master1.ansible.local:9000/b2b/farmer_loans/part-m-00000' USING PigStorage(',')
    AS (
        id:chararray,
        mayani_loan_product_id:chararray,
        loan_debt:chararray,
        time_to_pay:chararray,
        monthly_fee:chararray,
        date_of_approval:chararray,
        status:chararray,
        loan_description:chararray
    ); 
/* cargando granjeros */ 
farmers = LOAD 'hdfs://master1.ansible.local:9000/b2b/farmer_register/part-m-00000' USING PigStorage(',')
        AS (
                id:chararray, name:chararray, middle:chararray, surname:chararray, sex:chararray,
                address:chararray, contact:chararray, birthday:chararray, birthplace:chararray,
                birthcontry:chararray, religion:chararray, civilstatus:chararray, spouse:chararray, 
                education:chararray, governmentid:chararray, finger1:chararray, finger2:chararray,
                finger3:chararray, finger4:chararray
        );
/* cargando tabla many to many de granjeros y grupos */ 
farmer_group = LOAD 'hdfs://master1.ansible.local:9000/b2b/farmer_register_group/part-m-00000' USING PigStorage(',')
        AS (farmerid:chararray, groupid:chararray);

/* tabla de grupos */ 
groups = LOAD 'hdfs://master1.ansible.local:9000/b2b/group/part-m-00000' USING PigStorage(',')
        AS (id: chararray,name: chararray,idnumber: chararray,year: chararray);

/* cargando tabla many to many de granjas y grupos */ 
group_farm = LOAD 'hdfs://master1.ansible.local:9000/b2b/group_farm/part-m-00000' USING PigStorage(',')
    AS (
        group_id:chararray,
        farm_id:chararray
    ); 

/* cargando actualiación de inventario en el tiempo */ 
inventory_update = LOAD 'hdfs://master1.ansible.local:9000/b2b/inventory_update/part-m-00000' USING PigStorage(',')
    AS (
        id:chararray,
        inventory_id:chararray,
        quantity_kg:chararray,
        credit:chararray,
        date:chararray
    );

/* cargando pagos de prestamos */ 
loan_payment = LOAD 'hdfs://master1.ansible.local:9000/b2b/loan_payment/part-m-00000' USING PigStorage(',')
    AS (
        id:chararray,
        farmer_balance_id:chararray,
        loan_id:chararray,
        date:chararray,
        quantity_paid:chararray
    );

/* cargando ubicaciones de las granjas */ 
locations = LOAD 'hdfs://master1.ansible.local:9000/b2b/location/part-m-00000' USING PigStorage(',')
    AS (
        farm_location_id: chararray,
        farm_location_house: chararray,
        farm_location_street: chararray,
        farm_location_barangay: chararray,
        farm_location_municipality: chararray,
        farm_location_province: chararray,
        farm_location_region: chararray
    );

/* cargando productos de prestamos */ 

mayani_loan_products = LOAD 'hdfs://master1.ansible.local:9000/b2b/mayani_loan_products/part-m-00000' USING PigStorage(',')
    AS (
        id:chararray,
        name:chararray,
        description:chararray,
        loan_interest:chararray
    );

/* cargando solicitudes de inventario */ 
mayani_request_inventory = LOAD 'hdfs://master1.ansible.local:9000/b2b/mayani_request_inventory/part-m-00000' USING PigStorage(',')
    AS (
        id:chararray,
        quantity_kg:chararray,
        debt:chararray,
        date:chararray,
        description:chararray
    );
/* cargando inventario de productos controlado por Mayani */
mayani_product_inventory = LOAD 'hdfs://master1.ansible.local:9000/b2b/mayani_product_inventory/part-m-00000' USING PigStorage(',')
    AS (
        id:chararray,
        description:chararray,
        total_inventory_kg:chararray,
        total_value:chararray
    );
/* cargando relacion request_inventory farm_inventory */ 
mayani_request_inventory_farm_inventory = LOAD 'hdfs://master1.ansible.local:9000/b2b/mayani_request_inventory_farm_inventory/part-m-00000' USING PigStorage(',')
    AS (
        mayani_request_inventory_id:chararray,
        farm_inventory_id:chararray
    );

/* cargando relacion request_inventory farmer balance */ 
mayani_request_inventory_farmer_balance = LOAD 'hdfs://master1.ansible.local:9000/b2b/mayani_request_inventory_farmer_balance/part-m-00000' USING PigStorage(',')
    AS (
        mayani_request_inventory_id:chararray,
        farmer_balance_id:chararray
    );

/* cargando relacion request_inventory  y product inventory */ 
mayani_request_inventory_mayani_product_inventory = LOAD 'hdfs://master1.ansible.local:9000/b2b/mayani_request_inventory_mayani_product_inventory/part-m-00000' USING PigStorage(',')
    AS (
        mayani_request_inventory_id:chararray,
        mayani_product_inventory_id:chararray
    );

/* cargando productos */ 
product = LOAD 'hdfs://master1.ansible.local:9000/b2b/product/part-m-00000' USING PigStorage(',')
    AS (
        product_id:chararray,
        activity_id:chararray,
        farm_id:chararray,
        product_name:chararray,
        product_price_kg:chararray,
        prod_kg_month:chararray
    );

/* join entre tabla de grupos */
join_groups = JOIN groups BY id, farmer_group by groupid;
/* join entre granjeros y grupos */
join_farmer_group = JOIN farmers BY id, join_groups BY farmer_group::farmerid;
/* --------------------- */
/* join entre inventario y producto */
join_inventory_product = JOIN farm_inventory BY product_id, product BY product_id;
join_inventory_product = ORDER join_inventory_product BY farm_inventory::farm_id;
/* --------------------- */
/* join inventario, producto y actividad */
join_inventory_product_activity = JOIN join_inventory_product BY product::activity_id, activity BY activity_id;
join_inventory_product_activity = ORDER join_inventory_product_activity BY farm_inventory::farm_id;
/* --------------------- */
/* join location y granja */
join_farm = JOIN farms by location_id, locations BY farm_location_id;
/* --------------------- */
/* join farm y farmer */
join_farmer_farm = JOIN join_farmer_group BY farmers::id,  join_farm BY farms::farmer_id;
/* --------------------- */
/* uniendo granjeros, granjas, grupos, inventario, actividades y productos */
join_whole_farmers = JOIN join_farmer_farm BY farms::farm_id, join_inventory_product_activity BY farm_inventory::farm_id;
/* ordenando actualizaciones de inventario */


/*inventory_update = ORDER inventory_update BY inventory_id;*/
/* join farmer whole y updates */
/*join_whole_farmers = JOIN join_whole_farmers BY farm_inventory::fi_id, inventory_update BY inventory_id;
join_whole_farmers = ORDER join_whole_farmers BY farmers::id;*/

/* ---------------------- */
/* ---------------------- */
/* ---------------------- */

/* mayani product inventory  en tabla pivote*/
join_prod_inv = JOIN mayani_product_inventory 
                    BY id, 
                mayani_request_inventory_mayani_product_inventory 
                    BY mayani_product_inventory_id;
/* ---------------------- */
/* mayani product inventory y tabla de solicitud de inventarios a granjas*/
join_req_prod_inv = JOIN join_prod_inv 
                        BY mayani_request_inventory_mayani_product_inventory::mayani_request_inventory_id,
                    mayani_request_inventory 
                        BY id;
join_req_prod_inv = ORDER join_req_prod_inv BY mayani_product_inventory::id;
/* ---------------------- */
/* solicitudes de b2c a mayani */
/* b2_cproduct_request = ORDER b2_cproduct_request BY mayani_inventory_id; */
/*join_b2c = JOIN b2_cproduct_request 
                BY mayani_inventory_id,
            join_req_prod_inv
                BY  mayani_product_inventory::id;
join_b2c = ORDER join_b2c BY mayani_product_inventory::id;*/
/* join con tabla pivote de solicitud de inventario e inventario de granjas */

may_req_inv_farm_inv = ORDER mayani_request_inventory_farm_inventory BY mayani_request_inventory_id ASC;

join_mayani = JOIN join_req_prod_inv 
                BY mayani_request_inventory::id,
            may_req_inv_farm_inv
                BY mayani_request_inventory_id;
join_mayani = ORDER join_mayani BY may_req_inv_farm_inv::mayani_request_inventory_id;

/* ---------------------- */
/* ---------------------- */
/* ---------------------- */
/* join de balance del granjero y tabla pivote de prestamos y balance */
join_loans = JOIN farmer_loans BY id, farmer_balance_farmer_loans BY farmer_loans_id;
join_loans = JOIN join_loans by farmer_loans::mayani_loan_product_id, mayani_loan_products BY id;
join_loans = ORDER join_loans BY farmer_balance_farmer_loans::farmer_balance_id;
/* join loans y balance de granjeros */
join_loans_balance = JOIN join_loans 
                        BY farmer_balance_farmer_loans::farmer_balance_id,
                    farmer_balance 
                        BY id;


/*
describe join_whole_farmers;
describe join_mayani; 
describe join_loans_balance;
*/


/* uniendo granjeros, granjas, balances y prestamos*/

join_whole_farmers_balance = JOIN join_whole_farmers BY farmers::id,
                            join_loans_balance BY farmer_balance::farmer_id;


/* uniendo a solicitudes de productos relacionadas con Mayani */

join_whole_farmers_balance_mayani = JOIN join_whole_farmers_balance BY farm_inventory::fi_id, 
                                    join_mayani BY may_req_inv_farm_inv::farm_inventory_id;
/*join_whole_farmers_balance_mayani = ORDER join_whole_farmers_balance_mayani BY farmers::id;
join_whole_farmers_balance_mayani = LIMIT join_whole_farmers_balance_mayani 10000;*/




/*Dump join_whole_farmers_balance_mayani;*/

STORE join_lbp_farmers INTO '/join_whole_farmers_balance_mayani' USING PigStorage (',');

