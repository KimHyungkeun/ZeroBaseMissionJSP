create database if not exists zerobase_mission1;

create table if not exists zerobase_mission1.mainhome
(
    x_swifi_mgr_no      varchar(255) collate utf8mb3_swedish_ci not null,
    x_swifi_wrdofc      varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_main_nm     varchar(255) collate utf8mb3_swedish_ci not null,
    x_swifi_adres1      varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_adres2      varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_instl_floor varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_instl_ty    varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_instl_mby   varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_svc_se      varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_cmcwr       varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_cnstc_year  varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_inout_door  varchar(255) collate utf8mb3_swedish_ci null,
    x_swifi_remars3     varchar(255) collate utf8mb3_swedish_ci null,
    lat                 double                                  null,
    lnt                 double                                  null,
    work_dttm           varchar(255) collate utf8mb3_swedish_ci null,
    primary key (x_swifi_mgr_no, x_swifi_main_nm)
    )
    engine = InnoDB
    charset = utf8mb3;

create table if not exists zerobase_mission1.historys
(
    id         int auto_increment
    primary key,
    x_pos      double    null,
    y_pos      double    null,
    check_date timestamp null
)
    engine = InnoDB
    charset = utf8mb3;

create table if not exists zerobase_mission1.bookmarkgroup
(
    id                  int auto_increment,
    bookmark_group_name varchar(255) collate utf8mb3_swedish_ci not null,
    orders              int                                     null,
    register_date       timestamp                               null,
    update_date         timestamp                               null,
    primary key (id, bookmark_group_name)
)
    engine = InnoDB
    charset = utf8mb3;

create table if not exists zerobase_mission1.bookmarklist
(
    id                  int auto_increment
        primary key,
    bookmark_group_id   int                                     null,
    bookmark_group_name varchar(255) collate utf8mb3_swedish_ci null,
    wifi_manager_no     varchar(255) collate utf8mb3_swedish_ci null,
    wifi_name           varchar(255) collate utf8mb3_swedish_ci null,
    register_date       timestamp                               null,
    constraint for1
        foreign key (bookmark_group_id, bookmark_group_name) references bookmarkgroup (id, bookmark_group_name)
            on update cascade on delete cascade,
    constraint for2
        foreign key (wifi_manager_no, wifi_name) references mainhome (x_swifi_mgr_no, x_swifi_main_nm)
            on update cascade on delete cascade
)
    engine = InnoDB
    charset = utf8mb3;

