/*************************************************************
 Carga de archivos de base de datos B2C almacenados en HDFS  
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

/* tabla de historia de la orden*/
order_history = LOAD 'hdfs://master1.ansible.local:9000/b2c/ps_order_history/part-m-00000' USING PigStorage(',')
    AS (
        id_order_history:chararray,
        id_employee:chararray,
        id_order:chararray,
        id_order_state:chararray,
        date_add:chararray
    );


/*************************************************************
 proceso de desnormalización 
 **************************************************************/

/* join de tablas de orders */
filter_orders = FILTER orders BY id_lang =='1'; /* solo filtrado por idioma ingles */
join_whole_orders = JOIN filter_orders BY id_order, 
                order_detail BY id_order, 
                order_carrier BY id_order,
                order_history BY id_order;
/*Dump join_orders;*/


/*************************************************************
 Almacenamiento de tabla desnormalizada en HDFS  
 **************************************************************/

STORE join_whole_orders INTO '/join_whole_orders' USING PigStorage (',');

