/*************************************************************
 Carga de archivos de base de datos B2B almacenados en HDFS  
 **************************************************************/

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
/*farm_activity = LOAD 'hdfs://master1.ansible.local:9000/b2b/farm_activity/part-m-00000' USING PigStorage(',')
    AS (
        farm_id:chararray,
        activity_id:chararray
    );*/
/* cargando grupo de las granjas */
/*farm_group =  LOAD 'hdfs://master1.ansible.local:9000/b2b/farm_group/part-m-00000' USING PigStorage(',')
    AS (
        farm_id:chararray,
        group_id:chararray
    );*/
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
/*************************************************************
 PROCESO DE DESNORMALIACION POR PARTES
 **************************************************************/
 /* TABLAS RELACIONADAS AL GRANJERO */

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

/* join de balance del granjero y tabla pivote de prestamos y balance */
join_loans = JOIN farmer_loans BY id, farmer_balance_farmer_loans BY farmer_loans_id;
join_loans = JOIN join_loans by farmer_loans::mayani_loan_product_id, mayani_loan_products BY id;
join_loans = ORDER join_loans BY farmer_balance_farmer_loans::farmer_balance_id;
/* join loans y balance de granjeros */
join_loans_balance = JOIN join_loans BY farmer_balance_farmer_loans::farmer_balance_id,
                    farmer_balance BY id;

/* uniendo granjeros, granjas, balances y prestamos */

join_whole_farmers_balance = JOIN join_whole_farmers BY farmers::id,
                            join_loans_balance BY farmer_balance::farmer_id;


/* 
** La  tabla join_whole_farmers_balance desnormalizada representa la rama del granjero, su producción y 
** balance general. En el proceso anterior se incluyen las siguientes tablas:

Tablas:
- farmers
- farmer_group
- farm_inventory
- activity
- products
- farms
- locations
- farmer_loans
- farmer_balance_farmer_loans
- mayani_loan_products
- farmer_balance

NO SERA NECESARIO DESNORMALIZAR LAS SIGUIENTES TABLAS YA QUE REPRESENTAN UNA DIMENSIÓN
*************************************************************
 tablas que no seran desnormalizadas de b2b  y formarán parte de las dimensiones
 * loan_payment
 * inventory_update
 **************************************************************

** simplificando campos en la tabla desnormalizada de b2b
** descartados los siguientes campos, ya que no seran utilizados por estar repetidos 
** o no seran utilizados:

    farmers::finger1: chararray,
    farmers::finger2: chararray,
    farmers::finger3: chararray,
    farmers::finger4: chararray,
    farmer_group::farmerid,
    farms::farmer_id: chararray,
    farms::location_id : chararray,
    locations::farm_location_id: chararray,
    farm_inventory::farm_id: chararray,
    product::product_id: chararray,
    product::farm_id: chararray,
    product::activity_id: chararray,
    farmer_loans::mayani_loan_product_id: chararray,
    farmer_balance_farmer_loans::farmer_balance_id: chararray,
    farmer_balance_farmer_loans::farmer_loans_id: chararray,
    farmer_balance::farmer_id: chararray,
*/
join_whole_farmers = FOREACH join_whole_farmers_balance 
            GENERATE 
                farmers::id as farmer_id: chararray,
                farmers::name as farmer_name: chararray,
                farmers::middle as farmer_middle: chararray,
                farmers::surname as farmer_surname: chararray,
                farmers::sex as farmer_sex: chararray,
                farmers::address as farmer_address: chararray,
                farmers::contact as farmer_contact: chararray,
                farmers::birthday as farmer_birthday: chararray,
                farmers::birthplace as farmer_birthplace: chararray,
                farmers::birthcontry as farmer_birthcontry: chararray,
                farmers::religion as farmer_religion: chararray,
                farmers::civilstatus as farmer_civilstatus: chararray,
                farmers::spouse as farmer_spouse: chararray,
                farmers::education as farmer_education: chararray,
                farmers::governmentid as farmer_governmentid: chararray,
                groups::id as groups_id: chararray,
                groups::name as groups_name: chararray,
                groups::idnumber as groups_idnumber: chararray,
                groups::year as groups_year: chararray,
                farms::farm_id as farmid: chararray,
                farms::farm_name as farm_name: chararray,
                locations::farm_location_house as farm_house: chararray,
                locations::farm_location_street as farm_street: chararray,
                locations::farm_location_barangay as farm_barangay: chararray,
                locations::farm_location_municipality as farm_municipality: chararray,
                locations::farm_location_province as farm_province: chararray,
                locations::farm_location_region as farm_region: chararray,
                farm_inventory::fi_id as inventory_id: chararray,
                farm_inventory::product_id as product_id: chararray,
                farm_inventory::fi_date as inventory_date: chararray,
                farm_inventory::fi_total_credit as inventory_total_credit: chararray,
                farm_inventory::fi_total_kg as inventory_total_kg: chararray,
                farm_inventory::fi_description as inventory_description: chararray,
                product::product_name as product_name: chararray,
                product::product_price_kg as price_per_kg: chararray,
                product::prod_kg_month as kg_per_month: chararray,
                activity::activity_id as activity_id: chararray,
                activity::name as activity_name: chararray,
                activity::description as activity_description: chararray,
                farmer_loans::id as loan_id: chararray,
                farmer_loans::loan_debt as loan_debt: chararray,
                farmer_loans::time_to_pay as time_to_pay: chararray,
                farmer_loans::monthly_fee as monthly_fee: chararray,
                farmer_loans::date_of_approval as date_of_approval: chararray,
                farmer_loans::status as loan_status: chararray,
                farmer_loans::loan_description as loan_description: chararray,
                mayani_loan_products::id as loan_type_id: chararray,
                mayani_loan_products::name as loan_type_name: chararray,
                mayani_loan_products::description as loan_type_description: chararray,
                mayani_loan_products::loan_interest as loan_interest: chararray,
                farmer_balance::id as farmer_balance_id: chararray,
                farmer_balance::total_debt as farmer_balance_debt: chararray,
                farmer_balance::total_credit as farmer_balance_credit: chararray,
                farmer_balance::total_monthly_fee as farmer_balance_monthly_fee: chararray,
                farmer_balance::farmer_description as farmer_description: chararray;

/*describe join_whole_farmers;*/             
/*Dump join_whole_farmers;*/



/*********************************************************************************************/
/*********************************************************************************************/
/*********************************************************************************************/
/* TABLAS RELACIONADAS AL CONTROL DE ACTIVOS O INVENTARIOS DE MAYANI */

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

may_req_inv_farm_inv = ORDER mayani_request_inventory_farm_inventory BY mayani_request_inventory_id ASC;

join_mayani = JOIN join_req_prod_inv 
                BY mayani_request_inventory::id,
            may_req_inv_farm_inv
                BY mayani_request_inventory_id;
join_mayani = ORDER join_mayani BY may_req_inv_farm_inv::mayani_request_inventory_id;


join_mayani_b2c = JOIN join_mayani BY mayani_product_inventory::id, b2_cproduct_request BY mayani_inventory_id;

join_whole_mayani = JOIN join_mayani_b2c BY mayani_request_inventory::id, 
                            mayani_request_inventory_farmer_balance BY mayani_request_inventory_id;

/*describe join_whole_mayani;*/

/* 
** La tabla desnormalizada anteriormente representa la rama de mayani que contiene las siguientes tablas
** relacionadas al control de activos o inventario de mayani
Tablas:
- mayani_product_inventory
- mayani_request_inventory
- mayani_request_inventory_farm_inventory
- mayani_request_inventory_farmer_balance
- mayani_request_inventory_mayani_product_inventory
*/


/*********************************************************************************************/
/*********************************************************************************************/
/*********************************************************************************************/


/*************************************************************
 CARGA DE ARCHIVOS DE BASE DE DATOS B2C ALMACENADOS EN HDFS  
 **************************************************************/

/* cargando tablas de ordenes */


orders = LOAD 'hdfs://master1.ansible.local:9000/b2c/ps_orders/part-m-00000' USING PigStorage(',')
    AS (
        id_order:chararray,
        reference:chararray,
        id_shop_group:chararray,
        id_shop:chararray,
        id_carrier:chararray,
        id_lang:chararray,
        id_customer:chararray,
        id_cart:chararray,
        id_currency:chararray,
        d_address_delivery:chararray,
        id_address_invoice:chararray,
        current_state:chararray,
        secure_key:chararray,
        payment:chararray,
        conversion_rate:chararray,
        module:chararray,
        recyclable:chararray,
        gift:chararray,
        gift_message:chararray,
        mobile_theme:chararray,
        shipping_number:chararray,
        total_discounts:chararray,
        total_discounts_tax_incl:chararray,
        total_discounts_tax_excl:chararray,
        total_paid :chararray,
        total_paid_tax_incl:chararray,
        total_paid_tax_excl:chararray,
        total_paid_real:chararray,
        total_products:chararray,
        total_products_wt:chararray,
        total_shipping:chararray,
        total_shipping_tax_incl:chararray,
        total_shipping_tax_excl:chararray,
        carrier_tax_rate:chararray,
        total_wrapping:chararray,
        total_wrapping_tax_incl:chararray,
        total_wrapping_tax_excl:chararray,
        round_mode:chararray,
        round_type:chararray,
        invoice_number:chararray,
        delivery_number:chararray,
        invoice_date:chararray,
        delivery_date:chararray,
        valid:chararray,
        date_add:chararray,
        date_upd:chararray,
        note:chararray
    );

/* tabla del carrier de la orden*/

order_carrier = LOAD 'hdfs://master1.ansible.local:9000/b2c/ps_order_carrier/part-m-00000' USING PigStorage(',')
    AS (
        id_order_carrier:chararray,
        id_order:chararray,
        id_carrier:chararray,
        id_order_invoice:chararray,
        weight:chararray,
        shipping_cost_tax_excl:chararray,
        shipping_cost_tax_incl:chararray,
        tracking_number:chararray,
        date_add:chararray
    );
/* tabla de detalles de la orden*/
order_detail = LOAD 'hdfs://master1.ansible.local:9000/b2c/ps_order_detail/part-m-00000' USING PigStorage(',')
    AS (
        id_order_detail:chararray,
        id_order:chararray,
        id_order_invoice:chararray,
        id_warehouse:chararray,
        id_shop:chararray,
        product_id:chararray,
        product_attribute_id:chararray,
        id_customization:chararray,
        product_name:chararray,
        product_quantity:chararray,
        product_quantity_in_stock:chararray,
        product_quantity_refunded:chararray,
        product_quantity_return:chararray,
        product_quantity_reinjected:chararray,
        product_price:chararray,
        reduction_percent:chararray,
        reduction_amount:chararray,
        reduction_amount_tax_incl:chararray,
        reduction_amount_tax_excl:chararray,
        group_reduction:chararray,
        product_quantity_discount:chararray,
        product_ean13:chararray,
        product_isbn:chararray,
        product_upc:chararray,
        product_mpn:chararray,
        product_reference:chararray,
        product_supplier_reference:chararray,
        product_weight:chararray,
        id_tax_rules_group:chararray,
        tax_computation_method:chararray,
        tax_name:chararray,
        tax_rate:chararray,
        ecotax:chararray,
        ecotax_tax_rate:chararray,
        discount_quantity_applied:chararray,
        download_hash:chararray,
        download_nb:chararray,
        download_deadline:chararray,
        total_price_tax_incl:chararray,
        total_price_tax_excl:chararray,
        unit_price_tax_incl:chararray,
        unit_price_tax_excl:chararray,
        total_shipping_price_tax_incl:chararray,
        total_shipping_price_tax_excl:chararray,
        purchase_supplier_price:chararray,
        original_product_price:chararray,
        original_wholesale_price:chararray,
        total_refunded_tax_excl:chararray,
        total_refunded_tax_incl:chararray
    );
manufacturer = LOAD 'hdfs://master1.ansible.local:9000/b2c/ps_manufacturer/part-m-00000' USING PigStorage(',')
            AS (
                id: chararray,
                manufacturer_name: chararray,
                date1: chararray,
                date2: chararray,
                switch: chararray
            );


/*************************************************************
 proceso de desnormalización 
 **************************************************************/

/* join de tablas de orders */
filter_orders = FILTER orders BY id_lang =='1'; /* solo filtrado por idioma ingles */
join_whole_orders = JOIN filter_orders BY id_order, 
                order_detail BY id_order, 
                order_carrier BY id_order;



/*                
describe join_whole_orders;
*/

/* depuración de tabla desnormalizada de ordenes */
/*
los siguientes campos serán descartados de la tabla consolidada
*/


join_whole_orders = FOREACH join_whole_orders GENERATE 
    filter_orders::id_order as id_order: chararray,
    filter_orders::reference as order_reference: chararray,
    filter_orders::id_shop_group as id_shop_group: chararray,
    filter_orders::id_shop as id_shop: chararray,
    filter_orders::id_carrier as id_carrier: chararray,
    filter_orders::id_lang as id_lang: chararray,
    filter_orders::id_customer as id_customer: chararray,
    filter_orders::id_cart as id_cart: chararray,
    filter_orders::id_currency as id_currency: chararray,
    filter_orders::d_address_delivery as d_address_delivery: chararray,
    filter_orders::id_address_invoice as id_address_invoice: chararray,
    filter_orders::current_state as current_state: chararray,
    filter_orders::secure_key as secure_key: chararray,
    filter_orders::payment as payment: chararray,
    filter_orders::conversion_rate as conversion_rate: chararray,
    filter_orders::module as module: chararray,
    filter_orders::recyclable as recyclable: chararray,
    filter_orders::gift as gift: chararray,
    filter_orders::gift_message as gift_message: chararray,
    filter_orders::mobile_theme as mobile_theme: chararray,
    filter_orders::shipping_number as shipping_number: chararray,
    filter_orders::total_discounts as total_discounts: chararray,
    filter_orders::total_discounts_tax_incl as total_discounts_tax_incl: chararray,
    filter_orders::total_discounts_tax_excl as total_discounts_tax_excl: chararray,
    filter_orders::total_paid as total_paid: chararray,
    filter_orders::total_paid_tax_incl as total_paid_tax_incl: chararray,
    filter_orders::total_paid_tax_excl as total_paid_tax_excl: chararray,
    filter_orders::total_paid_real as total_paid_real: chararray,
    filter_orders::total_products as total_products: chararray,
    filter_orders::total_products_wt as total_products_wt: chararray,
    filter_orders::total_shipping as total_shipping: chararray,
    filter_orders::total_shipping_tax_incl as total_shipping_tax_incl: chararray,
    filter_orders::total_shipping_tax_excl as total_shipping_tax_excl: chararray,
    filter_orders::carrier_tax_rate as carrier_tax_rate: chararray,
    filter_orders::total_wrapping as total_wrapping: chararray,
    filter_orders::total_wrapping_tax_incl as total_wrapping_tax_incl: chararray,
    filter_orders::total_wrapping_tax_excl as total_wrapping_tax_excl: chararray,
    filter_orders::round_mode as round_mode: chararray,
    filter_orders::round_type as round_type: chararray,
    filter_orders::invoice_number as invoice_number: chararray,
    filter_orders::delivery_number as delivery_number: chararray,
    filter_orders::invoice_date as invoice_date: chararray,
    filter_orders::delivery_date as delivery_date: chararray,
    filter_orders::valid as valid: chararray,
    filter_orders::date_add as date_add: chararray,
    filter_orders::date_upd as date_upd: chararray,
    filter_orders::note as note: chararray,
    order_detail::id_order_detail as id_order_detail: chararray,
    order_detail::id_warehouse as id_warehouse: chararray,
    order_detail::product_id as product_id: chararray,
    order_detail::product_attribute_id as product_attribute_id: chararray,
    order_detail::id_customization as id_customization: chararray,
    order_detail::product_name as product_name: chararray,
    order_detail::product_quantity as product_quantity: chararray,
    order_detail::product_quantity_in_stock as product_quantity_in_stock: chararray,
    order_detail::product_quantity_refunded as product_quantity_refunded: chararray,
    order_detail::product_quantity_return as product_quantity_return: chararray,
    order_detail::product_quantity_reinjected as product_quantity_reinjected: chararray,
    order_detail::product_price as product_price: chararray,
    order_detail::reduction_percent as reduction_percent: chararray,
    order_detail::reduction_amount as reduction_amount: chararray,
    order_detail::reduction_amount_tax_incl as reduction_amount_tax_incl: chararray,
    order_detail::reduction_amount_tax_excl as reduction_amount_tax_excl: chararray,
    order_detail::group_reduction as group_reduction: chararray,
    order_detail::product_quantity_discount as product_quantity_discount: chararray,
    order_detail::product_ean13 as product_ean13: chararray,
    order_detail::product_isbn as product_isbn: chararray,
    order_detail::product_upc as product_upc: chararray,
    order_detail::product_mpn as product_mpn: chararray,
    order_detail::product_reference as product_reference: chararray,
    order_detail::product_supplier_reference as product_supplier_reference: chararray,
    order_detail::product_weight as product_weight: chararray,
    order_detail::id_tax_rules_group as id_tax_rules_group: chararray,
    order_detail::tax_computation_method as tax_computation_method: chararray,
    order_detail::tax_name as tax_name: chararray,
    order_detail::tax_rate as tax_rate: chararray,
    order_detail::ecotax as ecotax: chararray,
    order_detail::ecotax_tax_rate as ecotax_tax_rate: chararray,
    order_detail::discount_quantity_applied as discount_quantity_applied: chararray,
    order_detail::download_hash as download_hash: chararray,
    order_detail::download_nb as download_nb: chararray,
    order_detail::download_deadline as download_deadline: chararray,
    order_detail::total_price_tax_incl as total_price_tax_incl: chararray,
    order_detail::total_price_tax_excl as total_price_tax_excl: chararray,
    order_detail::unit_price_tax_incl as unit_price_tax_incl: chararray,
    order_detail::unit_price_tax_excl as unit_price_tax_excl: chararray,
    order_detail::total_shipping_price_tax_incl as total_shipping_price_tax_incl: chararray,
    order_detail::total_shipping_price_tax_excl as total_shipping_price_tax_excl: chararray,
    order_detail::purchase_supplier_price as purchase_supplier_price: chararray,
    order_detail::original_product_price as original_product_price: chararray,
    order_detail::original_wholesale_price as original_wholesale_price: chararray,
    order_detail::total_refunded_tax_excl as total_refunded_tax_excl: chararray,
    order_detail::total_refunded_tax_incl as total_refunded_tax_incl: chararray,
    order_carrier::id_order_carrier as id_order_carrier: chararray,
    order_carrier::weight as weight: chararray,
    order_carrier::shipping_cost_tax_excl as shipping_cost_tax_excl: chararray,
    order_carrier::shipping_cost_tax_incl as shipping_cost_tax_incl: chararray,
    order_carrier::tracking_number as tracking_number: chararray;




describe join_whole_orders;

    

b2b_b2c = JOIN join_whole_farmers BY product_id, join_whole_orders BY product_id;


/*Dump b2b_b2c;*/



/*********************************************************************************************/
/*********************************************************************************************/
/*********************************************************************************************/


/**********************************************************************************************
 CONSTRUCION DE MODELO ESTRELLA CON PERFIL DE GRANJEROS COMO TABLA CENTRAL
 **********************************************************************************************/

/*describe b2b_b2c;*/

 /* LA TABLA CENTRAL "farmer_profile" ESTARÁ FORMADA POR LOS IDENTIFICADORES PRINCIPALES DEL RESTO DE LAS RELACIONES */

farmer_profile = FOREACH b2b_b2c GENERATE 
                join_whole_farmers::farmer_id as farmer_id: chararray;
farmer_profile = DISTINCT farmer_profile;


/* Dimensión de información del granjero */
farmer_information = FOREACH b2b_b2c GENERATE
                join_whole_farmers::farmer_id as farmer_id: chararray,
                join_whole_farmers::farmer_name as name: chararray,
                join_whole_farmers::farmer_middle as middle: chararray,
                join_whole_farmers::farmer_surname as surname: chararray,
                join_whole_farmers::farmer_sex as sex: chararray,
                join_whole_farmers::farmer_address as address: chararray,
                join_whole_farmers::farmer_contact as contact: chararray,
                join_whole_farmers::farmer_birthday as birthday: chararray,
                join_whole_farmers::farmer_birthplace as birthplace: chararray,
                join_whole_farmers::farmer_birthcontry as birthcontry: chararray,
                join_whole_farmers::farmer_religion as religion: chararray,
                join_whole_farmers::farmer_civilstatus as civilstatus: chararray,
                join_whole_farmers::farmer_spouse as spouse: chararray,
                join_whole_farmers::farmer_education as education: chararray,
                join_whole_farmers::farmer_governmentid as governmentid: chararray;
farmer_information = DISTINCT farmer_information;

/* Dimensión de grupos o sindicatos a los que pertenece el granjero */
farmer_groups = FOREACH b2b_b2c GENERATE
                join_whole_farmers::farmer_id as farmer_id: chararray,
                join_whole_farmers::groups_id as groups_id: chararray,
                join_whole_farmers::groups_name as groups_name: chararray,
                join_whole_farmers::groups_idnumber as groups_idnumber: chararray,
                join_whole_farmers::groups_year as groups_year: chararray;
farmer_groups = DISTINCT farmer_groups;

/* Dimensión de granjas del granjero */
farmer_farm = FOREACH b2b_b2c GENERATE
                join_whole_farmers::farmer_id as farmer_id: chararray,
                join_whole_farmers::farmid as farmid: chararray,
                join_whole_farmers::farm_name as farm_name: chararray,
                join_whole_farmers::farm_house as farm_house: chararray,
                join_whole_farmers::farm_street as farm_street: chararray,
                join_whole_farmers::farm_barangay as farm_barangay: chararray,
                join_whole_farmers::farm_municipality as farm_municipality: chararray,
                join_whole_farmers::farm_province as farm_province: chararray,
                join_whole_farmers::farm_region as farm_region: chararray;
farmer_farm = DISTINCT farmer_farm;

/* Dimensión de productos del granjero */
farmer_product = FOREACH b2b_b2c GENERATE
                join_whole_farmers::farmer_id as farmer_id: chararray,
                join_whole_farmers::inventory_id as inventory_id: chararray,
                join_whole_farmers::product_id as product_id: chararray,
                join_whole_farmers::inventory_date as inventory_date: chararray,
                join_whole_farmers::inventory_total_credit as inventory_total_credit: chararray,
                join_whole_farmers::inventory_total_kg as inventory_total_kg: chararray,
                join_whole_farmers::inventory_description as inventory_description: chararray,
                join_whole_farmers::product_name as product_name: chararray,
                join_whole_farmers::price_per_kg as price_per_kg: chararray,
                join_whole_farmers::kg_per_month as kg_per_month: chararray,
                join_whole_farmers::activity_id as activity_id: chararray,
                join_whole_farmers::activity_name as activity_name: chararray,
                join_whole_farmers::activity_description as activity_description: chararray;
farmer_product = DISTINCT farmer_product;

/*Dimensión de prestamos realizados al granjero*/
farmer_loan_details = FOREACH b2b_b2c GENERATE
                join_whole_farmers::farmer_id as farmer_id: chararray,
                join_whole_farmers::loan_id as loan_id: chararray,
                join_whole_farmers::loan_debt as loan_debt: chararray,
                join_whole_farmers::time_to_pay as time_to_pay: chararray,
                join_whole_farmers::monthly_fee as monthly_fee: chararray,
                join_whole_farmers::date_of_approval as date_of_approval: chararray,
                join_whole_farmers::loan_status as loan_status: chararray,
                join_whole_farmers::loan_description as loan_description: chararray,
                join_whole_farmers::loan_type_id as loan_type_id: chararray,
                join_whole_farmers::loan_type_name as loan_type_name: chararray,
                join_whole_farmers::loan_type_description as loan_type_description: chararray,
                join_whole_farmers::loan_interest as loan_interest: chararray;
farmer_loan_details = DISTINCT farmer_loan_details;

/* Dimensión del balance general del granjero */
farmer_balances = FOREACH b2b_b2c GENERATE
                join_whole_farmers::farmer_id as farmer_id: chararray,
                join_whole_farmers::farmer_balance_id as balance_id: chararray,
                join_whole_farmers::farmer_balance_debt as farmer_balance_debt: chararray,
                join_whole_farmers::farmer_balance_credit as farmer_balance_credit: chararray,
                join_whole_farmers::farmer_balance_monthly_fee as farmer_balance_monthly_fee: chararray,
                join_whole_farmers::farmer_description as farmer_description: chararray;
farmer_balances = DISTINCT farmer_balances;

/* Dimensión de detalles de ventas realizadas del granjero */
farmer_sell_details = FOREACH b2b_b2c GENERATE
                join_whole_farmers::farmer_id as farmer_id: chararray,
                join_whole_orders::id_order as id_order: chararray,
                join_whole_orders::order_reference as order_reference: chararray,
                join_whole_orders::product_id as product_id: chararray,
                join_whole_orders::product_name as product_name: chararray,
                join_whole_orders::product_quantity as product_quantity: chararray,
                join_whole_orders::product_price as product_price: chararray,
                join_whole_orders::product_quantity_in_stock as product_quantity_in_stock: chararray,
                join_whole_orders::product_quantity_refunded as product_quantity_refunded: chararray,
                join_whole_orders::product_quantity_return as product_quantity_return: chararray,
                join_whole_orders::product_quantity_reinjected as product_quantity_reinjected: chararray,
                join_whole_orders::product_quantity_discount as product_quantity_discount: chararray,
                join_whole_orders::product_attribute_id as product_attribute_id: chararray,
                join_whole_orders::product_ean13 as product_ean13: chararray,
                join_whole_orders::product_isbn as product_isbn: chararray,
                join_whole_orders::product_upc as product_upc: chararray,
                join_whole_orders::product_mpn as product_mpn: chararray,
                join_whole_orders::product_reference as product_reference: chararray,
                join_whole_orders::product_supplier_reference as product_supplier_reference: chararray,
                join_whole_orders::product_weight as product_weight: chararray,
                join_whole_orders::total_discounts as total_discounts: chararray,
                join_whole_orders::total_discounts_tax_incl as total_discounts_tax_incl: chararray,
                join_whole_orders::total_discounts_tax_excl as total_discounts_tax_excl: chararray,
                join_whole_orders::total_paid as total_paid: chararray,
                join_whole_orders::total_paid_tax_incl as total_paid_tax_incl: chararray,
                join_whole_orders::total_paid_tax_excl as total_paid_tax_excl: chararray,
                join_whole_orders::total_paid_real as total_paid_real: chararray,
                join_whole_orders::total_products as total_products: chararray,
                join_whole_orders::total_products_wt as total_products_wt: chararray,
                join_whole_orders::total_shipping as total_shipping: chararray,
                join_whole_orders::total_price_tax_incl as total_price_tax_incl: chararray,
                join_whole_orders::total_price_tax_excl as total_price_tax_excl: chararray,
                join_whole_orders::total_refunded_tax_excl as total_refunded_tax_excl: chararray,
                join_whole_orders::total_refunded_tax_incl as total_refunded_tax_incl: chararray,
                join_whole_orders::total_shipping_price_tax_incl as total_shipping_price_tax_incl: chararray,
                join_whole_orders::total_shipping_price_tax_excl as total_shipping_price_tax_excl: chararray,
                join_whole_orders::shipping_cost_tax_excl as shipping_cost_tax_excl: chararray,
                join_whole_orders::shipping_cost_tax_incl as shipping_cost_tax_incl: chararray,
                join_whole_orders::id_customization as id_customization: chararray,
                join_whole_orders::reduction_percent as reduction_percent: chararray,
                join_whole_orders::reduction_amount as reduction_amount: chararray,
                join_whole_orders::reduction_amount_tax_incl as reduction_amount_tax_incl: chararray,
                join_whole_orders::reduction_amount_tax_excl as reduction_amount_tax_excl: chararray,
                join_whole_orders::group_reduction as group_reduction: chararray,
                join_whole_orders::id_shop_group as id_shop_group: chararray,
                join_whole_orders::id_shop as id_shop: chararray,
                join_whole_orders::id_carrier as id_carrier: chararray,
                join_whole_orders::id_lang as id_lang: chararray,
                join_whole_orders::id_customer as id_customer: chararray,
                join_whole_orders::id_cart as id_cart: chararray,
                join_whole_orders::id_currency as id_currency: chararray,
                join_whole_orders::d_address_delivery as d_address_delivery: chararray,
                join_whole_orders::id_address_invoice as id_address_invoice: chararray,
                join_whole_orders::current_state as current_state: chararray,
                join_whole_orders::payment as payment: chararray,
                join_whole_orders::conversion_rate as conversion_rate: chararray,
                join_whole_orders::module as module: chararray,
                join_whole_orders::recyclable as recyclable: chararray,
                join_whole_orders::gift as gift: chararray,
                join_whole_orders::gift_message as gift_message: chararray,
                join_whole_orders::mobile_theme as mobile_theme: chararray,
                join_whole_orders::shipping_number as shipping_number: chararray,
                join_whole_orders::carrier_tax_rate as carrier_tax_rate: chararray,
                join_whole_orders::total_wrapping as total_wrapping: chararray,
                join_whole_orders::total_wrapping_tax_incl as total_wrapping_tax_incl: chararray,
                join_whole_orders::total_wrapping_tax_excl as total_wrapping_tax_excl: chararray,
                join_whole_orders::round_mode as round_mode: chararray,
                join_whole_orders::round_type as round_type: chararray,
                join_whole_orders::invoice_number as invoice_number: chararray,
                join_whole_orders::delivery_number as delivery_number: chararray,
                join_whole_orders::invoice_date as invoice_date: chararray,
                join_whole_orders::delivery_date as delivery_date: chararray,
                join_whole_orders::valid as valid: chararray,
                join_whole_orders::date_add as date_add: chararray,
                join_whole_orders::date_upd as date_upd: chararray,
                join_whole_orders::note as note: chararray,
                join_whole_orders::id_order_detail as id_order_detail: chararray,
                join_whole_orders::id_warehouse as id_warehouse: chararray,
                join_whole_orders::id_tax_rules_group as id_tax_rules_group: chararray,
                join_whole_orders::tax_computation_method as tax_computation_method: chararray,
                join_whole_orders::tax_name as tax_name: chararray,
                join_whole_orders::tax_rate as tax_rate: chararray,
                join_whole_orders::ecotax as ecotax: chararray,
                join_whole_orders::ecotax_tax_rate as ecotax_tax_rate: chararray,
                join_whole_orders::discount_quantity_applied as discount_quantity_applied: chararray,
                join_whole_orders::download_hash as download_hash: chararray,
                join_whole_orders::download_nb as download_nb: chararray,
                join_whole_orders::download_deadline as download_deadline: chararray,
                join_whole_orders::unit_price_tax_incl as unit_price_tax_incl: chararray,
                join_whole_orders::unit_price_tax_excl as unit_price_tax_excl: chararray,
                join_whole_orders::purchase_supplier_price as purchase_supplier_price: chararray,
                join_whole_orders::original_product_price as original_product_price: chararray,
                join_whole_orders::original_wholesale_price as original_wholesale_price: chararray,
                join_whole_orders::id_order_carrier as id_order_carrier: chararray,
                join_whole_orders::weight as weight: chararray,
                join_whole_orders::tracking_number as tracking_number: chararray;
farmer_sell_details = DISTINCT farmer_sell_details;

/* Dimensión de actualización del inventario de productos del granjero */
/* se necesita hacer JOIN entre las actualizaciones de inventario 
no fueron  agregadas inicialmente en la tabla desnormalizada principal */


b2b_b2c = JOIN b2b_b2c BY join_whole_farmers::inventory_id, inventory_update BY inventory_id;
dim_inventory_update = FOREACH b2b_b2c GENERATE
                join_whole_farmers::farmer_id as farmer_id: chararray,
                inventory_update::id as inventory_update_id: chararray,
                inventory_update::inventory_id as inventory_id: chararray,
                inventory_update::quantity_kg as quantity_kg: chararray,
                inventory_update::credit as credit: chararray,
                inventory_update::date as date: chararray;

dim_inventory_update = DISTINCT dim_inventory_update;

/* Dimensión de pagos realizados a prestamos del granjero */
/* Se necesita hacer JOIN entre los pagos realizados a prestamos y la tabla desnormalizadas
ya que no fueron agregadas inicialmente */

b2b_b2c = JOIN b2b_b2c BY join_whole_farmers::farmer_balance_id, loan_payment BY farmer_balance_id;
dim_loan_payment = FOREACH b2b_b2c GENERATE
                join_whole_farmers::farmer_id as farmer_id: chararray,
                loan_payment::id as loan_payment_id:chararray,
                loan_payment::farmer_balance_id as farmer_balance_id:chararray,
                loan_payment::loan_id as loan_id:chararray,
                loan_payment::date as loan_date:chararray,
                loan_payment::quantity_paid as loan_quantity_paid:chararray;
dim_loan_payment = DISTINCT dim_loan_payment;
dim_loan_payment = ORDER dim_loan_payment BY farmer_id;
/*Dump dim_loan_payment;*/



/*************************************************************
 Almacenamiento de tablas desnormalizadas en HDFS  (OPCIONAL)
 Solo se debe descomentar las líneas correspondientes a STORE
 **************************************************************/

/* con esta opcion se guarda en la primera linea el nombre de los campos */

STORE farmer_profile INTO '/star-model/farmer_profile' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');
STORE farmer_information INTO '/star-model/farmer_information' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');
STORE farmer_groups INTO '/star-model/farmer_groups' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');
STORE farmer_farm INTO '/star-model/farmer_farm' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');
STORE farmer_product INTO '/star-model/farmer_product' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');
STORE farmer_loan_details INTO '/star-model/farmer_loan_details' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');
STORE farmer_balances INTO '/star-model/farmer_balances' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');
STORE farmer_sell_details INTO '/star-model/farmer_sell_details' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');
STORE dim_inventory_update INTO '/star-model/dim_inventory_update' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');
/*STORE dim_loan_payment INTO '/star-model/dim_loan_payment' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'WRITE_OUTPUT_HEADER');*/


/*
 Descartadas las tablas, no se tomarán en cuenta mas adelante, sicha información solo será tomada de 
 la tabla de productos y de granjeros
 * farm_activity 
 * farm_group
 
 */