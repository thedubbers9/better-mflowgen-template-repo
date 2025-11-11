// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================

// File Name: NV_NVDLA_cmac_DOUBLE.v

module NV_NVDLA_cmac_DOUBLE (
   // CSB interface
   csb2cmac_a_req_pd,
   csb2cmac_a_req_pvld,

   // Clock / reset / control
   dla_clk_ovr_on_sync,
   global_clk_ovr_on_sync,
   clk,
   nvdla_core_rstn,

   // sc2mac data channel (pvld, mask, 128 bytes, pd)
   sc2mac_dat_pvld,
   sc2mac_dat_mask,
   sc2mac_dat_data0,  sc2mac_dat_data1,  sc2mac_dat_data2,  sc2mac_dat_data3,
   sc2mac_dat_data4,  sc2mac_dat_data5,  sc2mac_dat_data6,  sc2mac_dat_data7,
   sc2mac_dat_data8,  sc2mac_dat_data9,  sc2mac_dat_data10, sc2mac_dat_data11,
   sc2mac_dat_data12, sc2mac_dat_data13, sc2mac_dat_data14, sc2mac_dat_data15,
   sc2mac_dat_data16, sc2mac_dat_data17, sc2mac_dat_data18, sc2mac_dat_data19,
   sc2mac_dat_data20, sc2mac_dat_data21, sc2mac_dat_data22, sc2mac_dat_data23,
   sc2mac_dat_data24, sc2mac_dat_data25, sc2mac_dat_data26, sc2mac_dat_data27,
   sc2mac_dat_data28, sc2mac_dat_data29, sc2mac_dat_data30, sc2mac_dat_data31,
   sc2mac_dat_data32, sc2mac_dat_data33, sc2mac_dat_data34, sc2mac_dat_data35,
   sc2mac_dat_data36, sc2mac_dat_data37, sc2mac_dat_data38, sc2mac_dat_data39,
   sc2mac_dat_data40, sc2mac_dat_data41, sc2mac_dat_data42, sc2mac_dat_data43,
   sc2mac_dat_data44, sc2mac_dat_data45, sc2mac_dat_data46, sc2mac_dat_data47,
   sc2mac_dat_data48, sc2mac_dat_data49, sc2mac_dat_data50, sc2mac_dat_data51,
   sc2mac_dat_data52, sc2mac_dat_data53, sc2mac_dat_data54, sc2mac_dat_data55,
   sc2mac_dat_data56, sc2mac_dat_data57, sc2mac_dat_data58, sc2mac_dat_data59,
   sc2mac_dat_data60, sc2mac_dat_data61, sc2mac_dat_data62, sc2mac_dat_data63,
   sc2mac_dat_data64, sc2mac_dat_data65, sc2mac_dat_data66, sc2mac_dat_data67,
   sc2mac_dat_data68, sc2mac_dat_data69, sc2mac_dat_data70, sc2mac_dat_data71,
   sc2mac_dat_data72, sc2mac_dat_data73, sc2mac_dat_data74, sc2mac_dat_data75,
   sc2mac_dat_data76, sc2mac_dat_data77, sc2mac_dat_data78, sc2mac_dat_data79,
   sc2mac_dat_data80, sc2mac_dat_data81, sc2mac_dat_data82, sc2mac_dat_data83,
   sc2mac_dat_data84, sc2mac_dat_data85, sc2mac_dat_data86, sc2mac_dat_data87,
   sc2mac_dat_data88, sc2mac_dat_data89, sc2mac_dat_data90, sc2mac_dat_data91,
   sc2mac_dat_data92, sc2mac_dat_data93, sc2mac_dat_data94, sc2mac_dat_data95,
   sc2mac_dat_data96, sc2mac_dat_data97, sc2mac_dat_data98, sc2mac_dat_data99,
   sc2mac_dat_data100,sc2mac_dat_data101,sc2mac_dat_data102,sc2mac_dat_data103,
   sc2mac_dat_data104,sc2mac_dat_data105,sc2mac_dat_data106,sc2mac_dat_data107,
   sc2mac_dat_data108,sc2mac_dat_data109,sc2mac_dat_data110,sc2mac_dat_data111,
   sc2mac_dat_data112,sc2mac_dat_data113,sc2mac_dat_data114,sc2mac_dat_data115,
   sc2mac_dat_data116,sc2mac_dat_data117,sc2mac_dat_data118,sc2mac_dat_data119,
   sc2mac_dat_data120,sc2mac_dat_data121,sc2mac_dat_data122,sc2mac_dat_data123,
   sc2mac_dat_data124,sc2mac_dat_data125,sc2mac_dat_data126,sc2mac_dat_data127,
   sc2mac_dat_pd,

   // sc2mac weight channel (pvld, mask, 128 bytes, sel)
   sc2mac_wt_pvld,
   sc2mac_wt_mask,
   sc2mac_wt_data0,  sc2mac_wt_data1,  sc2mac_wt_data2,  sc2mac_wt_data3,
   sc2mac_wt_data4,  sc2mac_wt_data5,  sc2mac_wt_data6,  sc2mac_wt_data7,
   sc2mac_wt_data8,  sc2mac_wt_data9,  sc2mac_wt_data10, sc2mac_wt_data11,
   sc2mac_wt_data12, sc2mac_wt_data13, sc2mac_wt_data14, sc2mac_wt_data15,
   sc2mac_wt_data16, sc2mac_wt_data17, sc2mac_wt_data18, sc2mac_wt_data19,
   sc2mac_wt_data20, sc2mac_wt_data21, sc2mac_wt_data22, sc2mac_wt_data23,
   sc2mac_wt_data24, sc2mac_wt_data25, sc2mac_wt_data26, sc2mac_wt_data27,
   sc2mac_wt_data28, sc2mac_wt_data29, sc2mac_wt_data30, sc2mac_wt_data31,
   sc2mac_wt_data32, sc2mac_wt_data33, sc2mac_wt_data34, sc2mac_wt_data35,
   sc2mac_wt_data36, sc2mac_wt_data37, sc2mac_wt_data38, sc2mac_wt_data39,
   sc2mac_wt_data40, sc2mac_wt_data41, sc2mac_wt_data42, sc2mac_wt_data43,
   sc2mac_wt_data44, sc2mac_wt_data45, sc2mac_wt_data46, sc2mac_wt_data47,
   sc2mac_wt_data48, sc2mac_wt_data49, sc2mac_wt_data50, sc2mac_wt_data51,
   sc2mac_wt_data52, sc2mac_wt_data53, sc2mac_wt_data54, sc2mac_wt_data55,
   sc2mac_wt_data56, sc2mac_wt_data57, sc2mac_wt_data58, sc2mac_wt_data59,
   sc2mac_wt_data60, sc2mac_wt_data61, sc2mac_wt_data62, sc2mac_wt_data63,
   sc2mac_wt_data64, sc2mac_wt_data65, sc2mac_wt_data66, sc2mac_wt_data67,
   sc2mac_wt_data68, sc2mac_wt_data69, sc2mac_wt_data70, sc2mac_wt_data71,
   sc2mac_wt_data72, sc2mac_wt_data73, sc2mac_wt_data74, sc2mac_wt_data75,
   sc2mac_wt_data76, sc2mac_wt_data77, sc2mac_wt_data78, sc2mac_wt_data79,
   sc2mac_wt_data80, sc2mac_wt_data81, sc2mac_wt_data82, sc2mac_wt_data83,
   sc2mac_wt_data84, sc2mac_wt_data85, sc2mac_wt_data86, sc2mac_wt_data87,
   sc2mac_wt_data88, sc2mac_wt_data89, sc2mac_wt_data90, sc2mac_wt_data91,
   sc2mac_wt_data92, sc2mac_wt_data93, sc2mac_wt_data94, sc2mac_wt_data95,
   sc2mac_wt_data96, sc2mac_wt_data97, sc2mac_wt_data98, sc2mac_wt_data99,
   sc2mac_wt_data100,sc2mac_wt_data101,sc2mac_wt_data102,sc2mac_wt_data103,
   sc2mac_wt_data104,sc2mac_wt_data105,sc2mac_wt_data106,sc2mac_wt_data107,
   sc2mac_wt_data108,sc2mac_wt_data109,sc2mac_wt_data110,sc2mac_wt_data111,
   sc2mac_wt_data112,sc2mac_wt_data113,sc2mac_wt_data114,sc2mac_wt_data115,
   sc2mac_wt_data116,sc2mac_wt_data117,sc2mac_wt_data118,sc2mac_wt_data119,
   sc2mac_wt_data120,sc2mac_wt_data121,sc2mac_wt_data122,sc2mac_wt_data123,
   sc2mac_wt_data124,sc2mac_wt_data125,sc2mac_wt_data126,sc2mac_wt_data127,

   sc2mac_wt_sel,

   // clock gating / control
   tmc2slcg_disable_clock_gating,

   // CSB outputs
   cmac_a2csb_resp_pd,
   cmac_a2csb_resp_valid,
   csb2cmac_a_req_prdy,

   // mac2accu outputs
   mac2accu_data0, mac2accu_data1, mac2accu_data2, mac2accu_data3,
   mac2accu_data4, mac2accu_data5, mac2accu_data6, mac2accu_data7,
   mac2accu_mask, mac2accu_mode, mac2accu_pd, mac2accu_pvld,

   // select
   cmac_sel
);

// Port directions: declare inputs/outputs for the double cmac wrapper.
// Copied/adapted from the single-instance NV_NVDLA_cmac port declarations
// so the HDL parser can resolve port directions for all names used below.
input  clk;
input  nvdla_core_rstn;

output        cmac_a2csb_resp_valid;  /* data valid */
output [33:0] cmac_a2csb_resp_pd;     /* pkt_id_width=1 pkt_widths=33,33  */

input         csb2cmac_a_req_pvld;  /* data valid */
output        csb2cmac_a_req_prdy;  /* data return handshake */
input  [62:0] csb2cmac_a_req_pd;

output         mac2accu_pvld;   /* data valid */
output   [7:0] mac2accu_mask;
output   [7:0] mac2accu_mode;
output [175:0] mac2accu_data0;
output [175:0] mac2accu_data1;
output [175:0] mac2accu_data2;
output [175:0] mac2accu_data3;
output [175:0] mac2accu_data4;
output [175:0] mac2accu_data5;
output [175:0] mac2accu_data6;
output [175:0] mac2accu_data7;
output   [8:0] mac2accu_pd;

input         sc2mac_dat_pvld;     /* data valid */
input [127:0] sc2mac_dat_mask;
input   [7:0] sc2mac_dat_data0;
input   [7:0] sc2mac_dat_data1;
input   [7:0] sc2mac_dat_data2;
input   [7:0] sc2mac_dat_data3;
input   [7:0] sc2mac_dat_data4;
input   [7:0] sc2mac_dat_data5;
input   [7:0] sc2mac_dat_data6;
input   [7:0] sc2mac_dat_data7;
input   [7:0] sc2mac_dat_data8;
input   [7:0] sc2mac_dat_data9;
input   [7:0] sc2mac_dat_data10;
input   [7:0] sc2mac_dat_data11;
input   [7:0] sc2mac_dat_data12;
input   [7:0] sc2mac_dat_data13;
input   [7:0] sc2mac_dat_data14;
input   [7:0] sc2mac_dat_data15;
input   [7:0] sc2mac_dat_data16;
input   [7:0] sc2mac_dat_data17;
input   [7:0] sc2mac_dat_data18;
input   [7:0] sc2mac_dat_data19;
input   [7:0] sc2mac_dat_data20;
input   [7:0] sc2mac_dat_data21;
input   [7:0] sc2mac_dat_data22;
input   [7:0] sc2mac_dat_data23;
input   [7:0] sc2mac_dat_data24;
input   [7:0] sc2mac_dat_data25;
input   [7:0] sc2mac_dat_data26;
input   [7:0] sc2mac_dat_data27;
input   [7:0] sc2mac_dat_data28;
input   [7:0] sc2mac_dat_data29;
input   [7:0] sc2mac_dat_data30;
input   [7:0] sc2mac_dat_data31;
input   [7:0] sc2mac_dat_data32;
input   [7:0] sc2mac_dat_data33;
input   [7:0] sc2mac_dat_data34;
input   [7:0] sc2mac_dat_data35;
input   [7:0] sc2mac_dat_data36;
input   [7:0] sc2mac_dat_data37;
input   [7:0] sc2mac_dat_data38;
input   [7:0] sc2mac_dat_data39;
input   [7:0] sc2mac_dat_data40;
input   [7:0] sc2mac_dat_data41;
input   [7:0] sc2mac_dat_data42;
input   [7:0] sc2mac_dat_data43;
input   [7:0] sc2mac_dat_data44;
input   [7:0] sc2mac_dat_data45;
input   [7:0] sc2mac_dat_data46;
input   [7:0] sc2mac_dat_data47;
input   [7:0] sc2mac_dat_data48;
input   [7:0] sc2mac_dat_data49;
input   [7:0] sc2mac_dat_data50;
input   [7:0] sc2mac_dat_data51;
input   [7:0] sc2mac_dat_data52;
input   [7:0] sc2mac_dat_data53;
input   [7:0] sc2mac_dat_data54;
input   [7:0] sc2mac_dat_data55;
input   [7:0] sc2mac_dat_data56;
input   [7:0] sc2mac_dat_data57;
input   [7:0] sc2mac_dat_data58;
input   [7:0] sc2mac_dat_data59;
input   [7:0] sc2mac_dat_data60;
input   [7:0] sc2mac_dat_data61;
input   [7:0] sc2mac_dat_data62;
input   [7:0] sc2mac_dat_data63;
input   [7:0] sc2mac_dat_data64;
input   [7:0] sc2mac_dat_data65;
input   [7:0] sc2mac_dat_data66;
input   [7:0] sc2mac_dat_data67;
input   [7:0] sc2mac_dat_data68;
input   [7:0] sc2mac_dat_data69;
input   [7:0] sc2mac_dat_data70;
input   [7:0] sc2mac_dat_data71;
input   [7:0] sc2mac_dat_data72;
input   [7:0] sc2mac_dat_data73;
input   [7:0] sc2mac_dat_data74;
input   [7:0] sc2mac_dat_data75;
input   [7:0] sc2mac_dat_data76;
input   [7:0] sc2mac_dat_data77;
input   [7:0] sc2mac_dat_data78;
input   [7:0] sc2mac_dat_data79;
input   [7:0] sc2mac_dat_data80;
input   [7:0] sc2mac_dat_data81;
input   [7:0] sc2mac_dat_data82;
input   [7:0] sc2mac_dat_data83;
input   [7:0] sc2mac_dat_data84;
input   [7:0] sc2mac_dat_data85;
input   [7:0] sc2mac_dat_data86;
input   [7:0] sc2mac_dat_data87;
input   [7:0] sc2mac_dat_data88;
input   [7:0] sc2mac_dat_data89;
input   [7:0] sc2mac_dat_data90;
input   [7:0] sc2mac_dat_data91;
input   [7:0] sc2mac_dat_data92;
input   [7:0] sc2mac_dat_data93;
input   [7:0] sc2mac_dat_data94;
input   [7:0] sc2mac_dat_data95;
input   [7:0] sc2mac_dat_data96;
input   [7:0] sc2mac_dat_data97;
input   [7:0] sc2mac_dat_data98;
input   [7:0] sc2mac_dat_data99;
input   [7:0] sc2mac_dat_data100;
input   [7:0] sc2mac_dat_data101;
input   [7:0] sc2mac_dat_data102;
input   [7:0] sc2mac_dat_data103;
input   [7:0] sc2mac_dat_data104;
input   [7:0] sc2mac_dat_data105;
input   [7:0] sc2mac_dat_data106;
input   [7:0] sc2mac_dat_data107;
input   [7:0] sc2mac_dat_data108;
input   [7:0] sc2mac_dat_data109;
input   [7:0] sc2mac_dat_data110;
input   [7:0] sc2mac_dat_data111;
input   [7:0] sc2mac_dat_data112;
input   [7:0] sc2mac_dat_data113;
input   [7:0] sc2mac_dat_data114;
input   [7:0] sc2mac_dat_data115;
input   [7:0] sc2mac_dat_data116;
input   [7:0] sc2mac_dat_data117;
input   [7:0] sc2mac_dat_data118;
input   [7:0] sc2mac_dat_data119;
input   [7:0] sc2mac_dat_data120;
input   [7:0] sc2mac_dat_data121;
input   [7:0] sc2mac_dat_data122;
input   [7:0] sc2mac_dat_data123;
input   [7:0] sc2mac_dat_data124;
input   [7:0] sc2mac_dat_data125;
input   [7:0] sc2mac_dat_data126;
input   [7:0] sc2mac_dat_data127;
input   [8:0] sc2mac_dat_pd;

input         sc2mac_wt_pvld;     /* data valid */
input [127:0] sc2mac_wt_mask;
input   [7:0] sc2mac_wt_data0;
input   [7:0] sc2mac_wt_data1;
input   [7:0] sc2mac_wt_data2;
input   [7:0] sc2mac_wt_data3;
input   [7:0] sc2mac_wt_data4;
input   [7:0] sc2mac_wt_data5;
input   [7:0] sc2mac_wt_data6;
input   [7:0] sc2mac_wt_data7;
input   [7:0] sc2mac_wt_data8;
input   [7:0] sc2mac_wt_data9;
input   [7:0] sc2mac_wt_data10;
input   [7:0] sc2mac_wt_data11;
input   [7:0] sc2mac_wt_data12;
input   [7:0] sc2mac_wt_data13;
input   [7:0] sc2mac_wt_data14;
input   [7:0] sc2mac_wt_data15;
input   [7:0] sc2mac_wt_data16;
input   [7:0] sc2mac_wt_data17;
input   [7:0] sc2mac_wt_data18;
input   [7:0] sc2mac_wt_data19;
input   [7:0] sc2mac_wt_data20;
input   [7:0] sc2mac_wt_data21;
input   [7:0] sc2mac_wt_data22;
input   [7:0] sc2mac_wt_data23;
input   [7:0] sc2mac_wt_data24;
input   [7:0] sc2mac_wt_data25;
input   [7:0] sc2mac_wt_data26;
input   [7:0] sc2mac_wt_data27;
input   [7:0] sc2mac_wt_data28;
input   [7:0] sc2mac_wt_data29;
input   [7:0] sc2mac_wt_data30;
input   [7:0] sc2mac_wt_data31;
input   [7:0] sc2mac_wt_data32;
input   [7:0] sc2mac_wt_data33;
input   [7:0] sc2mac_wt_data34;
input   [7:0] sc2mac_wt_data35;
input   [7:0] sc2mac_wt_data36;
input   [7:0] sc2mac_wt_data37;
input   [7:0] sc2mac_wt_data38;
input   [7:0] sc2mac_wt_data39;
input   [7:0] sc2mac_wt_data40;
input   [7:0] sc2mac_wt_data41;
input   [7:0] sc2mac_wt_data42;
input   [7:0] sc2mac_wt_data43;
input   [7:0] sc2mac_wt_data44;
input   [7:0] sc2mac_wt_data45;
input   [7:0] sc2mac_wt_data46;
input   [7:0] sc2mac_wt_data47;
input   [7:0] sc2mac_wt_data48;
input   [7:0] sc2mac_wt_data49;
input   [7:0] sc2mac_wt_data50;
input   [7:0] sc2mac_wt_data51;
input   [7:0] sc2mac_wt_data52;
input   [7:0] sc2mac_wt_data53;
input   [7:0] sc2mac_wt_data54;
input   [7:0] sc2mac_wt_data55;
input   [7:0] sc2mac_wt_data56;
input   [7:0] sc2mac_wt_data57;
input   [7:0] sc2mac_wt_data58;
input   [7:0] sc2mac_wt_data59;
input   [7:0] sc2mac_wt_data60;
input   [7:0] sc2mac_wt_data61;
input   [7:0] sc2mac_wt_data62;
input   [7:0] sc2mac_wt_data63;
input   [7:0] sc2mac_wt_data64;
input   [7:0] sc2mac_wt_data65;
input   [7:0] sc2mac_wt_data66;
input   [7:0] sc2mac_wt_data67;
input   [7:0] sc2mac_wt_data68;
input   [7:0] sc2mac_wt_data69;
input   [7:0] sc2mac_wt_data70;
input   [7:0] sc2mac_wt_data71;
input   [7:0] sc2mac_wt_data72;
input   [7:0] sc2mac_wt_data73;
input   [7:0] sc2mac_wt_data74;
input   [7:0] sc2mac_wt_data75;
input   [7:0] sc2mac_wt_data76;
input   [7:0] sc2mac_wt_data77;
input   [7:0] sc2mac_wt_data78;
input   [7:0] sc2mac_wt_data79;
input   [7:0] sc2mac_wt_data80;
input   [7:0] sc2mac_wt_data81;
input   [7:0] sc2mac_wt_data82;
input   [7:0] sc2mac_wt_data83;
input   [7:0] sc2mac_wt_data84;
input   [7:0] sc2mac_wt_data85;
input   [7:0] sc2mac_wt_data86;
input   [7:0] sc2mac_wt_data87;
input   [7:0] sc2mac_wt_data88;
input   [7:0] sc2mac_wt_data89;
input   [7:0] sc2mac_wt_data90;
input   [7:0] sc2mac_wt_data91;
input   [7:0] sc2mac_wt_data92;
input   [7:0] sc2mac_wt_data93;
input   [7:0] sc2mac_wt_data94;
input   [7:0] sc2mac_wt_data95;
input   [7:0] sc2mac_wt_data96;
input   [7:0] sc2mac_wt_data97;
input   [7:0] sc2mac_wt_data98;
input   [7:0] sc2mac_wt_data99;
input   [7:0] sc2mac_wt_data100;
input   [7:0] sc2mac_wt_data101;
input   [7:0] sc2mac_wt_data102;
input   [7:0] sc2mac_wt_data103;
input   [7:0] sc2mac_wt_data104;
input   [7:0] sc2mac_wt_data105;
input   [7:0] sc2mac_wt_data106;
input   [7:0] sc2mac_wt_data107;
input   [7:0] sc2mac_wt_data108;
input   [7:0] sc2mac_wt_data109;
input   [7:0] sc2mac_wt_data110;
input   [7:0] sc2mac_wt_data111;
input   [7:0] sc2mac_wt_data112;
input   [7:0] sc2mac_wt_data113;
input   [7:0] sc2mac_wt_data114;
input   [7:0] sc2mac_wt_data115;
input   [7:0] sc2mac_wt_data116;
input   [7:0] sc2mac_wt_data117;
input   [7:0] sc2mac_wt_data118;
input   [7:0] sc2mac_wt_data119;
input   [7:0] sc2mac_wt_data120;
input   [7:0] sc2mac_wt_data121;
input   [7:0] sc2mac_wt_data122;
input   [7:0] sc2mac_wt_data123;
input   [7:0] sc2mac_wt_data124;
input   [7:0] sc2mac_wt_data125;
input   [7:0] sc2mac_wt_data126;
input   [7:0] sc2mac_wt_data127;
input   [7:0] sc2mac_wt_sel;

input   dla_clk_ovr_on_sync;
input   global_clk_ovr_on_sync;
input   tmc2slcg_disable_clock_gating;

// select signal used to mux signals between the two instances
input   cmac_sel;

// --- Internal wires: outputs from each instance ---
wire        cmac0_cmac_a2csb_resp_valid;
wire [33:0] cmac0_cmac_a2csb_resp_pd;
wire        cmac0_csb2cmac_a_req_prdy;

wire        cmac1_cmac_a2csb_resp_valid;
wire [33:0] cmac1_cmac_a2csb_resp_pd;
wire        cmac1_csb2cmac_a_req_prdy;

wire         cmac0_mac2accu_pvld;
wire   [7:0] cmac0_mac2accu_mask;
wire   [7:0] cmac0_mac2accu_mode;
wire [175:0] cmac0_mac2accu_data0;
wire [175:0] cmac0_mac2accu_data1;
wire [175:0] cmac0_mac2accu_data2;
wire [175:0] cmac0_mac2accu_data3;
wire [175:0] cmac0_mac2accu_data4;
wire [175:0] cmac0_mac2accu_data5;
wire [175:0] cmac0_mac2accu_data6;
wire [175:0] cmac0_mac2accu_data7;
wire   [8:0] cmac0_mac2accu_pd;

wire         cmac1_mac2accu_pvld;
wire   [7:0] cmac1_mac2accu_mask;
wire   [7:0] cmac1_mac2accu_mode;
wire [175:0] cmac1_mac2accu_data0;
wire [175:0] cmac1_mac2accu_data1;
wire [175:0] cmac1_mac2accu_data2;
wire [175:0] cmac1_mac2accu_data3;
wire [175:0] cmac1_mac2accu_data4;
wire [175:0] cmac1_mac2accu_data5;
wire [175:0] cmac1_mac2accu_data6;
wire [175:0] cmac1_mac2accu_data7;
wire   [8:0] cmac1_mac2accu_pd;

// --- Instantiate two NV_NVDLA_cmac modules ---
NV_NVDLA_cmac cmac0 (
   .csb2cmac_a_req_pd            (csb2cmac_a_req_pd),
   .csb2cmac_a_req_pvld          (csb2cmac_a_req_pvld),
   .dla_clk_ovr_on_sync          (dla_clk_ovr_on_sync),
   .global_clk_ovr_on_sync       (global_clk_ovr_on_sync),
   .clk                          (clk),
   .nvdla_core_rstn              (nvdla_core_rstn),

   .sc2mac_dat_pvld              (sc2mac_dat_pvld),
   .sc2mac_dat_mask              (sc2mac_dat_mask),
   .sc2mac_dat_data0             (sc2mac_dat_data0),
   .sc2mac_dat_data1             (sc2mac_dat_data1),
   .sc2mac_dat_data2             (sc2mac_dat_data2),
   .sc2mac_dat_data3             (sc2mac_dat_data3),
   .sc2mac_dat_data4             (sc2mac_dat_data4),
   .sc2mac_dat_data5             (sc2mac_dat_data5),
   .sc2mac_dat_data6             (sc2mac_dat_data6),
   .sc2mac_dat_data7             (sc2mac_dat_data7),
   .sc2mac_dat_data8             (sc2mac_dat_data8),
   .sc2mac_dat_data9             (sc2mac_dat_data9),
   .sc2mac_dat_data10            (sc2mac_dat_data10),
   .sc2mac_dat_data11            (sc2mac_dat_data11),
   .sc2mac_dat_data12            (sc2mac_dat_data12),
   .sc2mac_dat_data13            (sc2mac_dat_data13),
   .sc2mac_dat_data14            (sc2mac_dat_data14),
   .sc2mac_dat_data15            (sc2mac_dat_data15),
   .sc2mac_dat_data16            (sc2mac_dat_data16),
   .sc2mac_dat_data17            (sc2mac_dat_data17),
   .sc2mac_dat_data18            (sc2mac_dat_data18),
   .sc2mac_dat_data19            (sc2mac_dat_data19),
   .sc2mac_dat_data20            (sc2mac_dat_data20),
   .sc2mac_dat_data21            (sc2mac_dat_data21),
   .sc2mac_dat_data22            (sc2mac_dat_data22),
   .sc2mac_dat_data23            (sc2mac_dat_data23),
   .sc2mac_dat_data24            (sc2mac_dat_data24),
   .sc2mac_dat_data25            (sc2mac_dat_data25),
   .sc2mac_dat_data26            (sc2mac_dat_data26),
   .sc2mac_dat_data27            (sc2mac_dat_data27),
   .sc2mac_dat_data28            (sc2mac_dat_data28),
   .sc2mac_dat_data29            (sc2mac_dat_data29),
   .sc2mac_dat_data30            (sc2mac_dat_data30),
   .sc2mac_dat_data31            (sc2mac_dat_data31),
   .sc2mac_dat_data32            (sc2mac_dat_data32),
   .sc2mac_dat_data33            (sc2mac_dat_data33),
   .sc2mac_dat_data34            (sc2mac_dat_data34),
   .sc2mac_dat_data35            (sc2mac_dat_data35),
   .sc2mac_dat_data36            (sc2mac_dat_data36),
   .sc2mac_dat_data37            (sc2mac_dat_data37),
   .sc2mac_dat_data38            (sc2mac_dat_data38),
   .sc2mac_dat_data39            (sc2mac_dat_data39),
   .sc2mac_dat_data40            (sc2mac_dat_data40),
   .sc2mac_dat_data41            (sc2mac_dat_data41),
   .sc2mac_dat_data42            (sc2mac_dat_data42),
   .sc2mac_dat_data43            (sc2mac_dat_data43),
   .sc2mac_dat_data44            (sc2mac_dat_data44),
   .sc2mac_dat_data45            (sc2mac_dat_data45),
   .sc2mac_dat_data46            (sc2mac_dat_data46),
   .sc2mac_dat_data47            (sc2mac_dat_data47),
   .sc2mac_dat_data48            (sc2mac_dat_data48),
   .sc2mac_dat_data49            (sc2mac_dat_data49),
   .sc2mac_dat_data50            (sc2mac_dat_data50),
   .sc2mac_dat_data51            (sc2mac_dat_data51),
   .sc2mac_dat_data52            (sc2mac_dat_data52),
   .sc2mac_dat_data53            (sc2mac_dat_data53),
   .sc2mac_dat_data54            (sc2mac_dat_data54),
   .sc2mac_dat_data55            (sc2mac_dat_data55),
   .sc2mac_dat_data56            (sc2mac_dat_data56),
   .sc2mac_dat_data57            (sc2mac_dat_data57),
   .sc2mac_dat_data58            (sc2mac_dat_data58),
   .sc2mac_dat_data59            (sc2mac_dat_data59),
   .sc2mac_dat_data60            (sc2mac_dat_data60),
   .sc2mac_dat_data61            (sc2mac_dat_data61),
   .sc2mac_dat_data62            (sc2mac_dat_data62),
   .sc2mac_dat_data63            (sc2mac_dat_data63),
   .sc2mac_dat_data64            (sc2mac_dat_data64),
   .sc2mac_dat_data65            (sc2mac_dat_data65),
   .sc2mac_dat_data66            (sc2mac_dat_data66),
   .sc2mac_dat_data67            (sc2mac_dat_data67),
   .sc2mac_dat_data68            (sc2mac_dat_data68),
   .sc2mac_dat_data69            (sc2mac_dat_data69),
   .sc2mac_dat_data70            (sc2mac_dat_data70),
   .sc2mac_dat_data71            (sc2mac_dat_data71),
   .sc2mac_dat_data72            (sc2mac_dat_data72),
   .sc2mac_dat_data73            (sc2mac_dat_data73),
   .sc2mac_dat_data74            (sc2mac_dat_data74),
   .sc2mac_dat_data75            (sc2mac_dat_data75),
   .sc2mac_dat_data76            (sc2mac_dat_data76),
   .sc2mac_dat_data77            (sc2mac_dat_data77),
   .sc2mac_dat_data78            (sc2mac_dat_data78),
   .sc2mac_dat_data79            (sc2mac_dat_data79),
   .sc2mac_dat_data80            (sc2mac_dat_data80),
   .sc2mac_dat_data81            (sc2mac_dat_data81),
   .sc2mac_dat_data82            (sc2mac_dat_data82),
   .sc2mac_dat_data83            (sc2mac_dat_data83),
   .sc2mac_dat_data84            (sc2mac_dat_data84),
   .sc2mac_dat_data85            (sc2mac_dat_data85),
   .sc2mac_dat_data86            (sc2mac_dat_data86),
   .sc2mac_dat_data87            (sc2mac_dat_data87),
   .sc2mac_dat_data88            (sc2mac_dat_data88),
   .sc2mac_dat_data89            (sc2mac_dat_data89),
   .sc2mac_dat_data90            (sc2mac_dat_data90),
   .sc2mac_dat_data91            (sc2mac_dat_data91),
   .sc2mac_dat_data92            (sc2mac_dat_data92),
   .sc2mac_dat_data93            (sc2mac_dat_data93),
   .sc2mac_dat_data94            (sc2mac_dat_data94),
   .sc2mac_dat_data95            (sc2mac_dat_data95),
   .sc2mac_dat_data96            (sc2mac_dat_data96),
   .sc2mac_dat_data97            (sc2mac_dat_data97),
   .sc2mac_dat_data98            (sc2mac_dat_data98),
   .sc2mac_dat_data99            (sc2mac_dat_data99),
   .sc2mac_dat_data100           (sc2mac_dat_data100),
   .sc2mac_dat_data101           (sc2mac_dat_data101),
   .sc2mac_dat_data102           (sc2mac_dat_data102),
   .sc2mac_dat_data103           (sc2mac_dat_data103),
   .sc2mac_dat_data104           (sc2mac_dat_data104),
   .sc2mac_dat_data105           (sc2mac_dat_data105),
   .sc2mac_dat_data106           (sc2mac_dat_data106),
   .sc2mac_dat_data107           (sc2mac_dat_data107),
   .sc2mac_dat_data108           (sc2mac_dat_data108),
   .sc2mac_dat_data109           (sc2mac_dat_data109),
   .sc2mac_dat_data110           (sc2mac_dat_data110),
   .sc2mac_dat_data111           (sc2mac_dat_data111),
   .sc2mac_dat_data112           (sc2mac_dat_data112),
   .sc2mac_dat_data113           (sc2mac_dat_data113),
   .sc2mac_dat_data114           (sc2mac_dat_data114),
   .sc2mac_dat_data115           (sc2mac_dat_data115),
   .sc2mac_dat_data116           (sc2mac_dat_data116),
   .sc2mac_dat_data117           (sc2mac_dat_data117),
   .sc2mac_dat_data118           (sc2mac_dat_data118),
   .sc2mac_dat_data119           (sc2mac_dat_data119),
   .sc2mac_dat_data120           (sc2mac_dat_data120),
   .sc2mac_dat_data121           (sc2mac_dat_data121),
   .sc2mac_dat_data122           (sc2mac_dat_data122),
   .sc2mac_dat_data123           (sc2mac_dat_data123),
   .sc2mac_dat_data124           (sc2mac_dat_data124),
   .sc2mac_dat_data125           (sc2mac_dat_data125),
   .sc2mac_dat_data126           (sc2mac_dat_data126),
   .sc2mac_dat_data127           (sc2mac_dat_data127),
   .sc2mac_dat_pd                (sc2mac_dat_pd),

   .sc2mac_wt_pvld               (sc2mac_wt_pvld),
   .sc2mac_wt_mask               (sc2mac_wt_mask),
   .sc2mac_wt_data0              (sc2mac_wt_data0),
   .sc2mac_wt_data1              (sc2mac_wt_data1),
   .sc2mac_wt_data2              (sc2mac_wt_data2),
   .sc2mac_wt_data3              (sc2mac_wt_data3),
   .sc2mac_wt_data4              (sc2mac_wt_data4),
   .sc2mac_wt_data5              (sc2mac_wt_data5),
   .sc2mac_wt_data6              (sc2mac_wt_data6),
   .sc2mac_wt_data7              (sc2mac_wt_data7),
   .sc2mac_wt_data8              (sc2mac_wt_data8),
   .sc2mac_wt_data9              (sc2mac_wt_data9),
   .sc2mac_wt_data10             (sc2mac_wt_data10),
   .sc2mac_wt_data11             (sc2mac_wt_data11),
   .sc2mac_wt_data12             (sc2mac_wt_data12),
   .sc2mac_wt_data13             (sc2mac_wt_data13),
   .sc2mac_wt_data14             (sc2mac_wt_data14),
   .sc2mac_wt_data15             (sc2mac_wt_data15),
   .sc2mac_wt_data16             (sc2mac_wt_data16),
   .sc2mac_wt_data17             (sc2mac_wt_data17),
   .sc2mac_wt_data18             (sc2mac_wt_data18),
   .sc2mac_wt_data19             (sc2mac_wt_data19),
   .sc2mac_wt_data20             (sc2mac_wt_data20),
   .sc2mac_wt_data21             (sc2mac_wt_data21),
   .sc2mac_wt_data22             (sc2mac_wt_data22),
   .sc2mac_wt_data23             (sc2mac_wt_data23),
   .sc2mac_wt_data24             (sc2mac_wt_data24),
   .sc2mac_wt_data25             (sc2mac_wt_data25),
   .sc2mac_wt_data26             (sc2mac_wt_data26),
   .sc2mac_wt_data27             (sc2mac_wt_data27),
   .sc2mac_wt_data28             (sc2mac_wt_data28),
   .sc2mac_wt_data29             (sc2mac_wt_data29),
   .sc2mac_wt_data30             (sc2mac_wt_data30),
   .sc2mac_wt_data31             (sc2mac_wt_data31),
   .sc2mac_wt_data32             (sc2mac_wt_data32),
   .sc2mac_wt_data33             (sc2mac_wt_data33),
   .sc2mac_wt_data34             (sc2mac_wt_data34),
   .sc2mac_wt_data35             (sc2mac_wt_data35),
   .sc2mac_wt_data36             (sc2mac_wt_data36),
   .sc2mac_wt_data37             (sc2mac_wt_data37),
   .sc2mac_wt_data38             (sc2mac_wt_data38),
   .sc2mac_wt_data39             (sc2mac_wt_data39),
   .sc2mac_wt_data40             (sc2mac_wt_data40),
   .sc2mac_wt_data41             (sc2mac_wt_data41),
   .sc2mac_wt_data42             (sc2mac_wt_data42),
   .sc2mac_wt_data43             (sc2mac_wt_data43),
   .sc2mac_wt_data44             (sc2mac_wt_data44),
   .sc2mac_wt_data45             (sc2mac_wt_data45),
   .sc2mac_wt_data46             (sc2mac_wt_data46),
   .sc2mac_wt_data47             (sc2mac_wt_data47),
   .sc2mac_wt_data48             (sc2mac_wt_data48),
   .sc2mac_wt_data49             (sc2mac_wt_data49),
   .sc2mac_wt_data50             (sc2mac_wt_data50),
   .sc2mac_wt_data51             (sc2mac_wt_data51),
   .sc2mac_wt_data52             (sc2mac_wt_data52),
   .sc2mac_wt_data53             (sc2mac_wt_data53),
   .sc2mac_wt_data54             (sc2mac_wt_data54),
   .sc2mac_wt_data55             (sc2mac_wt_data55),
   .sc2mac_wt_data56             (sc2mac_wt_data56),
   .sc2mac_wt_data57             (sc2mac_wt_data57),
   .sc2mac_wt_data58             (sc2mac_wt_data58),
   .sc2mac_wt_data59             (sc2mac_wt_data59),
   .sc2mac_wt_data60             (sc2mac_wt_data60),
   .sc2mac_wt_data61             (sc2mac_wt_data61),
   .sc2mac_wt_data62             (sc2mac_wt_data62),
   .sc2mac_wt_data63             (sc2mac_wt_data63),
   .sc2mac_wt_data64             (sc2mac_wt_data64),
   .sc2mac_wt_data65             (sc2mac_wt_data65),
   .sc2mac_wt_data66             (sc2mac_wt_data66),
   .sc2mac_wt_data67             (sc2mac_wt_data67),
   .sc2mac_wt_data68             (sc2mac_wt_data68),
   .sc2mac_wt_data69             (sc2mac_wt_data69),
   .sc2mac_wt_data70             (sc2mac_wt_data70),
   .sc2mac_wt_data71             (sc2mac_wt_data71),
   .sc2mac_wt_data72             (sc2mac_wt_data72),
   .sc2mac_wt_data73             (sc2mac_wt_data73),
   .sc2mac_wt_data74             (sc2mac_wt_data74),
   .sc2mac_wt_data75             (sc2mac_wt_data75),
   .sc2mac_wt_data76             (sc2mac_wt_data76),
   .sc2mac_wt_data77             (sc2mac_wt_data77),
   .sc2mac_wt_data78             (sc2mac_wt_data78),
   .sc2mac_wt_data79             (sc2mac_wt_data79),
   .sc2mac_wt_data80             (sc2mac_wt_data80),
   .sc2mac_wt_data81             (sc2mac_wt_data81),
   .sc2mac_wt_data82             (sc2mac_wt_data82),
   .sc2mac_wt_data83             (sc2mac_wt_data83),
   .sc2mac_wt_data84             (sc2mac_wt_data84),
   .sc2mac_wt_data85             (sc2mac_wt_data85),
   .sc2mac_wt_data86             (sc2mac_wt_data86),
   .sc2mac_wt_data87             (sc2mac_wt_data87),
   .sc2mac_wt_data88             (sc2mac_wt_data88),
   .sc2mac_wt_data89             (sc2mac_wt_data89),
   .sc2mac_wt_data90             (sc2mac_wt_data90),
   .sc2mac_wt_data91             (sc2mac_wt_data91),
   .sc2mac_wt_data92             (sc2mac_wt_data92),
   .sc2mac_wt_data93             (sc2mac_wt_data93),
   .sc2mac_wt_data94             (sc2mac_wt_data94),
   .sc2mac_wt_data95             (sc2mac_wt_data95),
   .sc2mac_wt_data96             (sc2mac_wt_data96),
   .sc2mac_wt_data97             (sc2mac_wt_data97),
   .sc2mac_wt_data98             (sc2mac_wt_data98),
   .sc2mac_wt_data99             (sc2mac_wt_data99),
   .sc2mac_wt_data100            (sc2mac_wt_data100),
   .sc2mac_wt_data101            (sc2mac_wt_data101),
   .sc2mac_wt_data102            (sc2mac_wt_data102),
   .sc2mac_wt_data103            (sc2mac_wt_data103),
   .sc2mac_wt_data104            (sc2mac_wt_data104),
   .sc2mac_wt_data105            (sc2mac_wt_data105),
   .sc2mac_wt_data106            (sc2mac_wt_data106),
   .sc2mac_wt_data107            (sc2mac_wt_data107),
   .sc2mac_wt_data108            (sc2mac_wt_data108),
   .sc2mac_wt_data109            (sc2mac_wt_data109),
   .sc2mac_wt_data110            (sc2mac_wt_data110),
   .sc2mac_wt_data111            (sc2mac_wt_data111),
   .sc2mac_wt_data112            (sc2mac_wt_data112),
   .sc2mac_wt_data113            (sc2mac_wt_data113),
   .sc2mac_wt_data114            (sc2mac_wt_data114),
   .sc2mac_wt_data115            (sc2mac_wt_data115),
   .sc2mac_wt_data116            (sc2mac_wt_data116),
   .sc2mac_wt_data117            (sc2mac_wt_data117),
   .sc2mac_wt_data118            (sc2mac_wt_data118),
   .sc2mac_wt_data119            (sc2mac_wt_data119),
   .sc2mac_wt_data120            (sc2mac_wt_data120),
   .sc2mac_wt_data121            (sc2mac_wt_data121),
   .sc2mac_wt_data122            (sc2mac_wt_data122),
   .sc2mac_wt_data123            (sc2mac_wt_data123),
   .sc2mac_wt_data124            (sc2mac_wt_data124),
   .sc2mac_wt_data125            (sc2mac_wt_data125),
   .sc2mac_wt_data126            (sc2mac_wt_data126),
   .sc2mac_wt_data127            (sc2mac_wt_data127),

   .tmc2slcg_disable_clock_gating(tmc2slcg_disable_clock_gating),

   .cmac_a2csb_resp_pd           (cmac0_cmac_a2csb_resp_pd),
   .cmac_a2csb_resp_valid        (cmac0_cmac_a2csb_resp_valid),
   .csb2cmac_a_req_prdy          (cmac0_csb2cmac_a_req_prdy),

   .mac2accu_data0               (cmac0_mac2accu_data0),
   .mac2accu_data1               (cmac0_mac2accu_data1),
   .mac2accu_data2               (cmac0_mac2accu_data2),
   .mac2accu_data3               (cmac0_mac2accu_data3),
   .mac2accu_data4               (cmac0_mac2accu_data4),
   .mac2accu_data5               (cmac0_mac2accu_data5),
   .mac2accu_data6               (cmac0_mac2accu_data6),
   .mac2accu_data7               (cmac0_mac2accu_data7),
   .mac2accu_mask                (cmac0_mac2accu_mask),
   .mac2accu_mode                (cmac0_mac2accu_mode),
   .mac2accu_pd                  (cmac0_mac2accu_pd),
   .mac2accu_pvld                (cmac0_mac2accu_pvld)
);

NV_NVDLA_cmac cmac1 (
   .csb2cmac_a_req_pd            (csb2cmac_a_req_pd),
   .csb2cmac_a_req_pvld          (csb2cmac_a_req_pvld),
   .dla_clk_ovr_on_sync          (dla_clk_ovr_on_sync),
   .global_clk_ovr_on_sync       (global_clk_ovr_on_sync),
   .clk                          (clk),
   .nvdla_core_rstn              (nvdla_core_rstn),

   .sc2mac_dat_pvld              (sc2mac_dat_pvld),
   .sc2mac_dat_mask              (sc2mac_dat_mask),
   .sc2mac_dat_data0             (sc2mac_dat_data0),
   .sc2mac_dat_data1             (sc2mac_dat_data1),
   .sc2mac_dat_data2             (sc2mac_dat_data2),
   .sc2mac_dat_data3             (sc2mac_dat_data3),
   .sc2mac_dat_data4             (sc2mac_dat_data4),
   .sc2mac_dat_data5             (sc2mac_dat_data5),
   .sc2mac_dat_data6             (sc2mac_dat_data6),
   .sc2mac_dat_data7             (sc2mac_dat_data7),
   .sc2mac_dat_data8             (sc2mac_dat_data8),
   .sc2mac_dat_data9             (sc2mac_dat_data9),
   .sc2mac_dat_data10            (sc2mac_dat_data10),
   .sc2mac_dat_data11            (sc2mac_dat_data11),
   .sc2mac_dat_data12            (sc2mac_dat_data12),
   .sc2mac_dat_data13            (sc2mac_dat_data13),
   .sc2mac_dat_data14            (sc2mac_dat_data14),
   .sc2mac_dat_data15            (sc2mac_dat_data15),
   .sc2mac_dat_data16            (sc2mac_dat_data16),
   .sc2mac_dat_data17            (sc2mac_dat_data17),
   .sc2mac_dat_data18            (sc2mac_dat_data18),
   .sc2mac_dat_data19            (sc2mac_dat_data19),
   .sc2mac_dat_data20            (sc2mac_dat_data20),
   .sc2mac_dat_data21            (sc2mac_dat_data21),
   .sc2mac_dat_data22            (sc2mac_dat_data22),
   .sc2mac_dat_data23            (sc2mac_dat_data23),
   .sc2mac_dat_data24            (sc2mac_dat_data24),
   .sc2mac_dat_data25            (sc2mac_dat_data25),
   .sc2mac_dat_data26            (sc2mac_dat_data26),
   .sc2mac_dat_data27            (sc2mac_dat_data27),
   .sc2mac_dat_data28            (sc2mac_dat_data28),
   .sc2mac_dat_data29            (sc2mac_dat_data29),
   .sc2mac_dat_data30            (sc2mac_dat_data30),
   .sc2mac_dat_data31            (sc2mac_dat_data31),
   .sc2mac_dat_data32            (sc2mac_dat_data32),
   .sc2mac_dat_data33            (sc2mac_dat_data33),
   .sc2mac_dat_data34            (sc2mac_dat_data34),
   .sc2mac_dat_data35            (sc2mac_dat_data35),
   .sc2mac_dat_data36            (sc2mac_dat_data36),
   .sc2mac_dat_data37            (sc2mac_dat_data37),
   .sc2mac_dat_data38            (sc2mac_dat_data38),
   .sc2mac_dat_data39            (sc2mac_dat_data39),
   .sc2mac_dat_data40            (sc2mac_dat_data40),
   .sc2mac_dat_data41            (sc2mac_dat_data41),
   .sc2mac_dat_data42            (sc2mac_dat_data42),
   .sc2mac_dat_data43            (sc2mac_dat_data43),
   .sc2mac_dat_data44            (sc2mac_dat_data44),
   .sc2mac_dat_data45            (sc2mac_dat_data45),
   .sc2mac_dat_data46            (sc2mac_dat_data46),
   .sc2mac_dat_data47            (sc2mac_dat_data47),
   .sc2mac_dat_data48            (sc2mac_dat_data48),
   .sc2mac_dat_data49            (sc2mac_dat_data49),
   .sc2mac_dat_data50            (sc2mac_dat_data50),
   .sc2mac_dat_data51            (sc2mac_dat_data51),
   .sc2mac_dat_data52            (sc2mac_dat_data52),
   .sc2mac_dat_data53            (sc2mac_dat_data53),
   .sc2mac_dat_data54            (sc2mac_dat_data54),
   .sc2mac_dat_data55            (sc2mac_dat_data55),
   .sc2mac_dat_data56            (sc2mac_dat_data56),
   .sc2mac_dat_data57            (sc2mac_dat_data57),
   .sc2mac_dat_data58            (sc2mac_dat_data58),
   .sc2mac_dat_data59            (sc2mac_dat_data59),
   .sc2mac_dat_data60            (sc2mac_dat_data60),
   .sc2mac_dat_data61            (sc2mac_dat_data61),
   .sc2mac_dat_data62            (sc2mac_dat_data62),
   .sc2mac_dat_data63            (sc2mac_dat_data63),
   .sc2mac_dat_data64            (sc2mac_dat_data64),
   .sc2mac_dat_data65            (sc2mac_dat_data65),
   .sc2mac_dat_data66            (sc2mac_dat_data66),
   .sc2mac_dat_data67            (sc2mac_dat_data67),
   .sc2mac_dat_data68            (sc2mac_dat_data68),
   .sc2mac_dat_data69            (sc2mac_dat_data69),
   .sc2mac_dat_data70            (sc2mac_dat_data70),
   .sc2mac_dat_data71            (sc2mac_dat_data71),
   .sc2mac_dat_data72            (sc2mac_dat_data72),
   .sc2mac_dat_data73            (sc2mac_dat_data73),
   .sc2mac_dat_data74            (sc2mac_dat_data74),
   .sc2mac_dat_data75            (sc2mac_dat_data75),
   .sc2mac_dat_data76            (sc2mac_dat_data76),
   .sc2mac_dat_data77            (sc2mac_dat_data77),
   .sc2mac_dat_data78            (sc2mac_dat_data78),
   .sc2mac_dat_data79            (sc2mac_dat_data79),
   .sc2mac_dat_data80            (sc2mac_dat_data80),
   .sc2mac_dat_data81            (sc2mac_dat_data81),
   .sc2mac_dat_data82            (sc2mac_dat_data82),
   .sc2mac_dat_data83            (sc2mac_dat_data83),
   .sc2mac_dat_data84            (sc2mac_dat_data84),
   .sc2mac_dat_data85            (sc2mac_dat_data85),
   .sc2mac_dat_data86            (sc2mac_dat_data86),
   .sc2mac_dat_data87            (sc2mac_dat_data87),
   .sc2mac_dat_data88            (sc2mac_dat_data88),
   .sc2mac_dat_data89            (sc2mac_dat_data89),
   .sc2mac_dat_data90            (sc2mac_dat_data90),
   .sc2mac_dat_data91            (sc2mac_dat_data91),
   .sc2mac_dat_data92            (sc2mac_dat_data92),
   .sc2mac_dat_data93            (sc2mac_dat_data93),
   .sc2mac_dat_data94            (sc2mac_dat_data94),
   .sc2mac_dat_data95            (sc2mac_dat_data95),
   .sc2mac_dat_data96            (sc2mac_dat_data96),
   .sc2mac_dat_data97            (sc2mac_dat_data97),
   .sc2mac_dat_data98            (sc2mac_dat_data98),
   .sc2mac_dat_data99            (sc2mac_dat_data99),
   .sc2mac_dat_data100           (sc2mac_dat_data100),
   .sc2mac_dat_data101           (sc2mac_dat_data101),
   .sc2mac_dat_data102           (sc2mac_dat_data102),
   .sc2mac_dat_data103           (sc2mac_dat_data103),
   .sc2mac_dat_data104           (sc2mac_dat_data104),
   .sc2mac_dat_data105           (sc2mac_dat_data105),
   .sc2mac_dat_data106           (sc2mac_dat_data106),
   .sc2mac_dat_data107           (sc2mac_dat_data107),
   .sc2mac_dat_data108           (sc2mac_dat_data108),
   .sc2mac_dat_data109           (sc2mac_dat_data109),
   .sc2mac_dat_data110           (sc2mac_dat_data110),
   .sc2mac_dat_data111           (sc2mac_dat_data111),
   .sc2mac_dat_data112           (sc2mac_dat_data112),
   .sc2mac_dat_data113           (sc2mac_dat_data113),
   .sc2mac_dat_data114           (sc2mac_dat_data114),
   .sc2mac_dat_data115           (sc2mac_dat_data115),
   .sc2mac_dat_data116           (sc2mac_dat_data116),
   .sc2mac_dat_data117           (sc2mac_dat_data117),
   .sc2mac_dat_data118           (sc2mac_dat_data118),
   .sc2mac_dat_data119           (sc2mac_dat_data119),
   .sc2mac_dat_data120           (sc2mac_dat_data120),
   .sc2mac_dat_data121           (sc2mac_dat_data121),
   .sc2mac_dat_data122           (sc2mac_dat_data122),
   .sc2mac_dat_data123           (sc2mac_dat_data123),
   .sc2mac_dat_data124           (sc2mac_dat_data124),
   .sc2mac_dat_data125           (sc2mac_dat_data125),
   .sc2mac_dat_data126           (sc2mac_dat_data126),
   .sc2mac_dat_data127           (sc2mac_dat_data127),
   .sc2mac_dat_pd                (sc2mac_dat_pd),

   .sc2mac_wt_pvld               (sc2mac_wt_pvld),
   .sc2mac_wt_mask               (sc2mac_wt_mask),
   .sc2mac_wt_data0              (sc2mac_wt_data0),
   .sc2mac_wt_data1              (sc2mac_wt_data1),
   .sc2mac_wt_data2              (sc2mac_wt_data2),
   .sc2mac_wt_data3              (sc2mac_wt_data3),
   .sc2mac_wt_data4              (sc2mac_wt_data4),
   .sc2mac_wt_data5              (sc2mac_wt_data5),
   .sc2mac_wt_data6              (sc2mac_wt_data6),
   .sc2mac_wt_data7              (sc2mac_wt_data7),
   .sc2mac_wt_data8              (sc2mac_wt_data8),
   .sc2mac_wt_data9              (sc2mac_wt_data9),
   .sc2mac_wt_data10             (sc2mac_wt_data10),
   .sc2mac_wt_data11             (sc2mac_wt_data11),
   .sc2mac_wt_data12             (sc2mac_wt_data12),
   .sc2mac_wt_data13             (sc2mac_wt_data13),
   .sc2mac_wt_data14             (sc2mac_wt_data14),
   .sc2mac_wt_data15             (sc2mac_wt_data15),
   .sc2mac_wt_data16             (sc2mac_wt_data16),
   .sc2mac_wt_data17             (sc2mac_wt_data17),
   .sc2mac_wt_data18             (sc2mac_wt_data18),
   .sc2mac_wt_data19             (sc2mac_wt_data19),
   .sc2mac_wt_data20             (sc2mac_wt_data20),
   .sc2mac_wt_data21             (sc2mac_wt_data21),
   .sc2mac_wt_data22             (sc2mac_wt_data22),
   .sc2mac_wt_data23             (sc2mac_wt_data23),
   .sc2mac_wt_data24             (sc2mac_wt_data24),
   .sc2mac_wt_data25             (sc2mac_wt_data25),
   .sc2mac_wt_data26             (sc2mac_wt_data26),
   .sc2mac_wt_data27             (sc2mac_wt_data27),
   .sc2mac_wt_data28             (sc2mac_wt_data28),
   .sc2mac_wt_data29             (sc2mac_wt_data29),
   .sc2mac_wt_data30             (sc2mac_wt_data30),
   .sc2mac_wt_data31             (sc2mac_wt_data31),
   .sc2mac_wt_data32             (sc2mac_wt_data32),
   .sc2mac_wt_data33             (sc2mac_wt_data33),
   .sc2mac_wt_data34             (sc2mac_wt_data34),
   .sc2mac_wt_data35             (sc2mac_wt_data35),
   .sc2mac_wt_data36             (sc2mac_wt_data36),
   .sc2mac_wt_data37             (sc2mac_wt_data37),
   .sc2mac_wt_data38             (sc2mac_wt_data38),
   .sc2mac_wt_data39             (sc2mac_wt_data39),
   .sc2mac_wt_data40             (sc2mac_wt_data40),
   .sc2mac_wt_data41             (sc2mac_wt_data41),
   .sc2mac_wt_data42             (sc2mac_wt_data42),
   .sc2mac_wt_data43             (sc2mac_wt_data43),
   .sc2mac_wt_data44             (sc2mac_wt_data44),
   .sc2mac_wt_data45             (sc2mac_wt_data45),
   .sc2mac_wt_data46             (sc2mac_wt_data46),
   .sc2mac_wt_data47             (sc2mac_wt_data47),
   .sc2mac_wt_data48             (sc2mac_wt_data48),
   .sc2mac_wt_data49             (sc2mac_wt_data49),
   .sc2mac_wt_data50             (sc2mac_wt_data50),
   .sc2mac_wt_data51             (sc2mac_wt_data51),
   .sc2mac_wt_data52             (sc2mac_wt_data52),
   .sc2mac_wt_data53             (sc2mac_wt_data53),
   .sc2mac_wt_data54             (sc2mac_wt_data54),
   .sc2mac_wt_data55             (sc2mac_wt_data55),
   .sc2mac_wt_data56             (sc2mac_wt_data56),
   .sc2mac_wt_data57             (sc2mac_wt_data57),
   .sc2mac_wt_data58             (sc2mac_wt_data58),
   .sc2mac_wt_data59             (sc2mac_wt_data59),
   .sc2mac_wt_data60             (sc2mac_wt_data60),
   .sc2mac_wt_data61             (sc2mac_wt_data61),
   .sc2mac_wt_data62             (sc2mac_wt_data62),
   .sc2mac_wt_data63             (sc2mac_wt_data63),
   .sc2mac_wt_data64             (sc2mac_wt_data64),
   .sc2mac_wt_data65             (sc2mac_wt_data65),
   .sc2mac_wt_data66             (sc2mac_wt_data66),
   .sc2mac_wt_data67             (sc2mac_wt_data67),
   .sc2mac_wt_data68             (sc2mac_wt_data68),
   .sc2mac_wt_data69             (sc2mac_wt_data69),
   .sc2mac_wt_data70             (sc2mac_wt_data70),
   .sc2mac_wt_data71             (sc2mac_wt_data71),
   .sc2mac_wt_data72             (sc2mac_wt_data72),
   .sc2mac_wt_data73             (sc2mac_wt_data73),
   .sc2mac_wt_data74             (sc2mac_wt_data74),
   .sc2mac_wt_data75             (sc2mac_wt_data75),
   .sc2mac_wt_data76             (sc2mac_wt_data76),
   .sc2mac_wt_data77             (sc2mac_wt_data77),
   .sc2mac_wt_data78             (sc2mac_wt_data78),
   .sc2mac_wt_data79             (sc2mac_wt_data79),
   .sc2mac_wt_data80             (sc2mac_wt_data80),
   .sc2mac_wt_data81             (sc2mac_wt_data81),
   .sc2mac_wt_data82             (sc2mac_wt_data82),
   .sc2mac_wt_data83             (sc2mac_wt_data83),
   .sc2mac_wt_data84             (sc2mac_wt_data84),
   .sc2mac_wt_data85             (sc2mac_wt_data85),
   .sc2mac_wt_data86             (sc2mac_wt_data86),
   .sc2mac_wt_data87             (sc2mac_wt_data87),
   .sc2mac_wt_data88             (sc2mac_wt_data88),
   .sc2mac_wt_data89             (sc2mac_wt_data89),
   .sc2mac_wt_data90             (sc2mac_wt_data90),
   .sc2mac_wt_data91             (sc2mac_wt_data91),
   .sc2mac_wt_data92             (sc2mac_wt_data92),
   .sc2mac_wt_data93             (sc2mac_wt_data93),
   .sc2mac_wt_data94             (sc2mac_wt_data94),
   .sc2mac_wt_data95             (sc2mac_wt_data95),
   .sc2mac_wt_data96             (sc2mac_wt_data96),
   .sc2mac_wt_data97             (sc2mac_wt_data97),
   .sc2mac_wt_data98             (sc2mac_wt_data98),
   .sc2mac_wt_data99             (sc2mac_wt_data99),
   .sc2mac_wt_data100            (sc2mac_wt_data100),
   .sc2mac_wt_data101            (sc2mac_wt_data101),
   .sc2mac_wt_data102            (sc2mac_wt_data102),
   .sc2mac_wt_data103            (sc2mac_wt_data103),
   .sc2mac_wt_data104            (sc2mac_wt_data104),
   .sc2mac_wt_data105            (sc2mac_wt_data105),
   .sc2mac_wt_data106            (sc2mac_wt_data106),
   .sc2mac_wt_data107            (sc2mac_wt_data107),
   .sc2mac_wt_data108            (sc2mac_wt_data108),
   .sc2mac_wt_data109            (sc2mac_wt_data109),
   .sc2mac_wt_data110            (sc2mac_wt_data110),
   .sc2mac_wt_data111            (sc2mac_wt_data111),
   .sc2mac_wt_data112            (sc2mac_wt_data112),
   .sc2mac_wt_data113            (sc2mac_wt_data113),
   .sc2mac_wt_data114            (sc2mac_wt_data114),
   .sc2mac_wt_data115            (sc2mac_wt_data115),
   .sc2mac_wt_data116            (sc2mac_wt_data116),
   .sc2mac_wt_data117            (sc2mac_wt_data117),
   .sc2mac_wt_data118            (sc2mac_wt_data118),
   .sc2mac_wt_data119            (sc2mac_wt_data119),
   .sc2mac_wt_data120            (sc2mac_wt_data120),
   .sc2mac_wt_data121            (sc2mac_wt_data121),
   .sc2mac_wt_data122            (sc2mac_wt_data122),
   .sc2mac_wt_data123            (sc2mac_wt_data123),
   .sc2mac_wt_data124            (sc2mac_wt_data124),
   .sc2mac_wt_data125            (sc2mac_wt_data125),
   .sc2mac_wt_data126            (sc2mac_wt_data126),
   .sc2mac_wt_data127            (sc2mac_wt_data127),

   .tmc2slcg_disable_clock_gating(tmc2slcg_disable_clock_gating),

   .cmac_a2csb_resp_pd           (cmac1_cmac_a2csb_resp_pd),
   .cmac_a2csb_resp_valid        (cmac1_cmac_a2csb_resp_valid),
   .csb2cmac_a_req_prdy          (cmac1_csb2cmac_a_req_prdy),

   .mac2accu_data0               (cmac1_mac2accu_data0),
   .mac2accu_data1               (cmac1_mac2accu_data1),
   .mac2accu_data2               (cmac1_mac2accu_data2),
   .mac2accu_data3               (cmac1_mac2accu_data3),
   .mac2accu_data4               (cmac1_mac2accu_data4),
   .mac2accu_data5               (cmac1_mac2accu_data5),
   .mac2accu_data6               (cmac1_mac2accu_data6),
   .mac2accu_data7               (cmac1_mac2accu_data7),
   .mac2accu_mask                (cmac1_mac2accu_mask),
   .mac2accu_mode                (cmac1_mac2accu_mode),
   .mac2accu_pd                  (cmac1_mac2accu_pd),
   .mac2accu_pvld                (cmac1_mac2accu_pvld)
);

// --- Mux outputs to top-level outputs based on cmac_sel ---
assign cmac_a2csb_resp_valid = (cmac_sel) ? cmac1_cmac_a2csb_resp_valid : cmac0_cmac_a2csb_resp_valid;
assign cmac_a2csb_resp_pd    = (cmac_sel) ? cmac1_cmac_a2csb_resp_pd    : cmac0_cmac_a2csb_resp_pd;
assign csb2cmac_a_req_prdy   = (cmac_sel) ? cmac1_csb2cmac_a_req_prdy   : cmac0_csb2cmac_a_req_prdy;

assign mac2accu_pvld  = (cmac_sel) ? cmac1_mac2accu_pvld  : cmac0_mac2accu_pvld;
assign mac2accu_mask  = (cmac_sel) ? cmac1_mac2accu_mask  : cmac0_mac2accu_mask;
assign mac2accu_mode  = (cmac_sel) ? cmac1_mac2accu_mode  : cmac0_mac2accu_mode;
assign mac2accu_data0 = (cmac_sel) ? cmac1_mac2accu_data0 : cmac0_mac2accu_data0;
assign mac2accu_data1 = (cmac_sel) ? cmac1_mac2accu_data1 : cmac0_mac2accu_data1;
assign mac2accu_data2 = (cmac_sel) ? cmac1_mac2accu_data2 : cmac0_mac2accu_data2;
assign mac2accu_data3 = (cmac_sel) ? cmac1_mac2accu_data3 : cmac0_mac2accu_data3;
assign mac2accu_data4 = (cmac_sel) ? cmac1_mac2accu_data4 : cmac0_mac2accu_data4;
assign mac2accu_data5 = (cmac_sel) ? cmac1_mac2accu_data5 : cmac0_mac2accu_data5;
assign mac2accu_data6 = (cmac_sel) ? cmac1_mac2accu_data6 : cmac0_mac2accu_data6;
assign mac2accu_data7 = (cmac_sel) ? cmac1_mac2accu_data7 : cmac0_mac2accu_data7;
assign mac2accu_pd    = (cmac_sel) ? cmac1_mac2accu_pd    : cmac0_mac2accu_pd;

endmodule // NV_NVDLA_cmac_DOUBLE
