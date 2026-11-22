CREATE TABLE [staff] (
  [id] INTEGER PRIMARY KEY,
  [role_id] INTEGER NOT NULL,
  [department_id] INTEGER NOT NULL,
  [first_name] VARCHAR(100) NOT NULL,
  [last_name] VARCHAR(100) NOT NULL,
  [email] VARCHAR(255) NOT NULL,
  [phone] VARCHAR(20) NOT NULL,
  [hire_date] DATE NOT NULL
)
GO

CREATE TABLE [allergies] (
  [id] INTEGER PRIMARY KEY,
  [name] VARCHAR(100) NOT NULL,
  [description] TEXT NOT NULL
)
GO

CREATE TABLE [inventory_items] (
  [id] INTEGER PRIMARY KEY,
  [category_id] INTEGER NOT NULL,
  [name] VARCHAR(100) NOT NULL,
  [description] TEXT NOT NULL,
  [unit_price] DECIMAL(10,2) NOT NULL,
  [quantity_in_stock] INTEGER NOT NULL
)
GO

CREATE TABLE [purchase_orders] (
  [id] INTEGER PRIMARY KEY,
  [vendor_id] INTEGER NOT NULL,
  [order_date] DATE NOT NULL,
  [status] VARCHAR(50) NOT NULL,
  [total_cost] DECIMAL(12,2) NOT NULL
)
GO

CREATE TABLE [lab_results] (
  [id] INTEGER PRIMARY KEY,
  [request_id] INTEGER NOT NULL,
  [technician_id] INTEGER NOT NULL,
  [result_details] TEXT NOT NULL,
  [performed_date] datetime2 NOT NULL
)
GO

CREATE TABLE [schedules] (
  [id] INTEGER PRIMARY KEY,
  [staff_id] INTEGER NOT NULL,
  [shift_start] datetime2 NOT NULL,
  [shift_end] datetime2 NOT NULL,
  [day_of_week] VARCHAR(20) NOT NULL
)
GO

CREATE TABLE [inventory_categories] (
  [id] INTEGER PRIMARY KEY,
  [name] VARCHAR(100) NOT NULL,
  [description] TEXT NOT NULL
)
GO

CREATE TABLE [payments] (
  [id] INTEGER PRIMARY KEY,
  [billing_id] INTEGER NOT NULL,
  [amount] DECIMAL(10,2) NOT NULL,
  [payment_date] datetime2 NOT NULL,
  [payment_method] VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [medications] (
  [id] INTEGER PRIMARY KEY,
  [name] VARCHAR(100) NOT NULL,
  [brand] VARCHAR(100) NOT NULL,
  [description] TEXT NOT NULL,
  [dosage_form] VARCHAR(50) NOT NULL,
  [strength] VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [billing] (
  [id] INTEGER PRIMARY KEY,
  [patient_id] INTEGER NOT NULL,
  [total_amount] DECIMAL(10,2) NOT NULL,
  [paid_amount] DECIMAL(10,2) NOT NULL,
  [status] VARCHAR(50) NOT NULL,
  [billing_date] DATE NOT NULL
)
GO

CREATE TABLE [lab_requests] (
  [id] INTEGER PRIMARY KEY,
  [medical_record_id] INTEGER NOT NULL,
  [doctor_id] INTEGER NOT NULL,
  [test_id] INTEGER NOT NULL,
  [request_date] datetime2 NOT NULL,
  [status] VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [beds] (
  [id] INTEGER PRIMARY KEY,
  [room_id] INTEGER NOT NULL,
  [bed_number] VARCHAR(20) NOT NULL,
  [status] VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [rooms] (
  [id] INTEGER PRIMARY KEY,
  [ward_id] INTEGER NOT NULL,
  [room_number] VARCHAR(20) NOT NULL,
  [type] VARCHAR(50) NOT NULL,
  [status] VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [departments] (
  [id] INTEGER PRIMARY KEY,
  [name] VARCHAR(100) NOT NULL,
  [description] TEXT NOT NULL,
  [phone] VARCHAR(20) NOT NULL
)
GO

CREATE TABLE [purchase_order_items] (
  [id] INTEGER PRIMARY KEY,
  [purchase_order_id] INTEGER NOT NULL,
  [item_id] INTEGER NOT NULL,
  [quantity] INTEGER NOT NULL,
  [unit_price] DECIMAL(10,2) NOT NULL
)
GO

CREATE TABLE [prescriptions] (
  [id] INTEGER PRIMARY KEY,
  [medical_record_id] INTEGER NOT NULL,
  [doctor_id] INTEGER NOT NULL,
  [prescribed_date] DATE NOT NULL,
  [instructions] TEXT NOT NULL
)
GO

CREATE TABLE [patient_allergies] (
  [id] INTEGER PRIMARY KEY,
  [patient_id] INTEGER NOT NULL,
  [allergy_id] INTEGER NOT NULL,
  [severity] VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [staff_roles] (
  [id] INTEGER PRIMARY KEY,
  [title] VARCHAR(100) NOT NULL,
  [description] TEXT NOT NULL
)
GO

CREATE TABLE [appointments] (
  [id] INTEGER PRIMARY KEY,
  [patient_id] INTEGER NOT NULL,
  [doctor_id] INTEGER NOT NULL,
  [appointment_date] datetime2 NOT NULL,
  [status] VARCHAR(50) NOT NULL,
  [notes] TEXT NOT NULL
)
GO

CREATE TABLE [admissions] (
  [id] INTEGER PRIMARY KEY,
  [patient_id] INTEGER NOT NULL,
  [bed_id] INTEGER NOT NULL,
  [admission_date] datetime2 NOT NULL,
  [discharge_date] datetime2 NOT NULL,
  [primary_diagnosis] TEXT NOT NULL
)
GO

CREATE TABLE [patients] (
  [id] INTEGER PRIMARY KEY,
  [first_name] VARCHAR(100) NOT NULL,
  [last_name] VARCHAR(100) NOT NULL,
  [date_of_birth] DATE NOT NULL,
  [gender] VARCHAR(20) NOT NULL,
  [phone] VARCHAR(20) NOT NULL,
  [email] VARCHAR(255) NOT NULL,
  [address] VARCHAR(255) NOT NULL,
  [emergency_contact] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [medical_records] (
  [id] INTEGER PRIMARY KEY,
  [patient_id] INTEGER NOT NULL,
  [doctor_id] INTEGER NOT NULL,
  [created_at] datetime2 NOT NULL,
  [diagnosis] TEXT NOT NULL,
  [treatment_plan] TEXT NOT NULL
)
GO

CREATE TABLE [doctors] (
  [id] INTEGER PRIMARY KEY,
  [staff_id] INTEGER NOT NULL,
  [license_number] VARCHAR(100) NOT NULL,
  [specialty] VARCHAR(100) NOT NULL,
  [biography] TEXT NOT NULL
)
GO

CREATE TABLE [visitors] (
  [id] INTEGER PRIMARY KEY,
  [patient_id] INTEGER NOT NULL,
  [name] VARCHAR(100) NOT NULL,
  [relationship] VARCHAR(50) NOT NULL,
  [visit_time_in] datetime2 NOT NULL,
  [visit_time_out] datetime2 NOT NULL
)
GO

CREATE TABLE [insurance_providers] (
  [id] INTEGER PRIMARY KEY,
  [name] VARCHAR(100) NOT NULL,
  [contact_person] VARCHAR(100) NOT NULL,
  [phone] VARCHAR(20) NOT NULL,
  [email] VARCHAR(255) NOT NULL,
  [address] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [surgical_procedures] (
  [id] INTEGER PRIMARY KEY,
  [admission_id] INTEGER NOT NULL,
  [surgery_id] INTEGER NOT NULL,
  [lead_surgeon_id] INTEGER NOT NULL,
  [scheduled_time] datetime2 NOT NULL,
  [duration_minutes] INTEGER NOT NULL
)
GO

CREATE TABLE [vendors] (
  [id] INTEGER PRIMARY KEY,
  [name] VARCHAR(100) NOT NULL,
  [contact_name] VARCHAR(100) NOT NULL,
  [phone] VARCHAR(20) NOT NULL,
  [email] VARCHAR(255) NOT NULL,
  [address] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [wards] (
  [id] INTEGER PRIMARY KEY,
  [department_id] INTEGER NOT NULL,
  [name] VARCHAR(100) NOT NULL,
  [type] VARCHAR(50) NOT NULL,
  [capacity] INTEGER NOT NULL
)
GO

CREATE TABLE [prescription_items] (
  [id] INTEGER PRIMARY KEY,
  [prescription_id] INTEGER NOT NULL,
  [medication_id] INTEGER NOT NULL,
  [dosage] VARCHAR(100) NOT NULL,
  [frequency] VARCHAR(100) NOT NULL,
  [duration] VARCHAR(100) NOT NULL
)
GO

CREATE TABLE [surgeries] (
  [id] INTEGER PRIMARY KEY,
  [name] VARCHAR(100) NOT NULL,
  [description] TEXT NOT NULL,
  [risk_level] VARCHAR(50) NOT NULL
)
GO

CREATE TABLE [billing_items] (
  [id] INTEGER PRIMARY KEY,
  [billing_id] INTEGER NOT NULL,
  [description] VARCHAR(255) NOT NULL,
  [amount] DECIMAL(10,2) NOT NULL
)
GO

CREATE TABLE [insurance_policies] (
  [id] INTEGER PRIMARY KEY,
  [patient_id] INTEGER NOT NULL,
  [provider_id] INTEGER NOT NULL,
  [policy_number] VARCHAR(100) NOT NULL,
  [coverage_details] TEXT NOT NULL,
  [expiry_date] DATE NOT NULL
)
GO

CREATE TABLE [lab_tests] (
  [id] INTEGER PRIMARY KEY,
  [name] VARCHAR(100) NOT NULL,
  [description] TEXT NOT NULL,
  [cost] DECIMAL(10,2) NOT NULL
)
GO

ALTER TABLE [doctors] ADD FOREIGN KEY ([staff_id]) REFERENCES [staff] ([id])
GO

ALTER TABLE [patient_allergies] ADD FOREIGN KEY ([allergy_id]) REFERENCES [allergies] ([id])
GO

ALTER TABLE [purchase_orders] ADD FOREIGN KEY ([vendor_id]) REFERENCES [vendors] ([id])
GO

ALTER TABLE [appointments] ADD FOREIGN KEY ([doctor_id]) REFERENCES [doctors] ([id])
GO

ALTER TABLE [prescription_items] ADD FOREIGN KEY ([prescription_id]) REFERENCES [prescriptions] ([id])
GO

ALTER TABLE [beds] ADD FOREIGN KEY ([room_id]) REFERENCES [rooms] ([id])
GO

ALTER TABLE [medical_records] ADD FOREIGN KEY ([patient_id]) REFERENCES [patients] ([id])
GO

ALTER TABLE [insurance_policies] ADD FOREIGN KEY ([patient_id]) REFERENCES [patients] ([id])
GO

ALTER TABLE [appointments] ADD FOREIGN KEY ([patient_id]) REFERENCES [patients] ([id])
GO

ALTER TABLE [wards] ADD FOREIGN KEY ([department_id]) REFERENCES [departments] ([id])
GO

ALTER TABLE [surgical_procedures] ADD FOREIGN KEY ([surgery_id]) REFERENCES [surgeries] ([id])
GO

ALTER TABLE [visitors] ADD FOREIGN KEY ([patient_id]) REFERENCES [patients] ([id])
GO

ALTER TABLE [surgical_procedures] ADD FOREIGN KEY ([lead_surgeon_id]) REFERENCES [doctors] ([id])
GO

ALTER TABLE [admissions] ADD FOREIGN KEY ([bed_id]) REFERENCES [beds] ([id])
GO

ALTER TABLE [inventory_items] ADD FOREIGN KEY ([category_id]) REFERENCES [inventory_categories] ([id])
GO

ALTER TABLE [rooms] ADD FOREIGN KEY ([ward_id]) REFERENCES [wards] ([id])
GO

ALTER TABLE [purchase_order_items] ADD FOREIGN KEY ([item_id]) REFERENCES [inventory_items] ([id])
GO

ALTER TABLE [schedules] ADD FOREIGN KEY ([staff_id]) REFERENCES [staff] ([id])
GO

ALTER TABLE [surgical_procedures] ADD FOREIGN KEY ([admission_id]) REFERENCES [admissions] ([id])
GO

ALTER TABLE [billing] ADD FOREIGN KEY ([patient_id]) REFERENCES [patients] ([id])
GO

ALTER TABLE [lab_requests] ADD FOREIGN KEY ([doctor_id]) REFERENCES [doctors] ([id])
GO

ALTER TABLE [medical_records] ADD FOREIGN KEY ([doctor_id]) REFERENCES [doctors] ([id])
GO

ALTER TABLE [lab_requests] ADD FOREIGN KEY ([test_id]) REFERENCES [lab_tests] ([id])
GO

ALTER TABLE [staff] ADD FOREIGN KEY ([department_id]) REFERENCES [departments] ([id])
GO

ALTER TABLE [lab_results] ADD FOREIGN KEY ([request_id]) REFERENCES [lab_requests] ([id])
GO

ALTER TABLE [insurance_policies] ADD FOREIGN KEY ([provider_id]) REFERENCES [insurance_providers] ([id])
GO

ALTER TABLE [lab_results] ADD FOREIGN KEY ([technician_id]) REFERENCES [staff] ([id])
GO

ALTER TABLE [billing_items] ADD FOREIGN KEY ([billing_id]) REFERENCES [billing] ([id])
GO

ALTER TABLE [purchase_order_items] ADD FOREIGN KEY ([purchase_order_id]) REFERENCES [purchase_orders] ([id])
GO

ALTER TABLE [staff] ADD FOREIGN KEY ([role_id]) REFERENCES [staff_roles] ([id])
GO

ALTER TABLE [patient_allergies] ADD FOREIGN KEY ([patient_id]) REFERENCES [patients] ([id])
GO

ALTER TABLE [prescriptions] ADD FOREIGN KEY ([doctor_id]) REFERENCES [doctors] ([id])
GO

ALTER TABLE [lab_requests] ADD FOREIGN KEY ([medical_record_id]) REFERENCES [medical_records] ([id])
GO

ALTER TABLE [payments] ADD FOREIGN KEY ([billing_id]) REFERENCES [billing] ([id])
GO

ALTER TABLE [admissions] ADD FOREIGN KEY ([patient_id]) REFERENCES [patients] ([id])
GO

ALTER TABLE [prescription_items] ADD FOREIGN KEY ([medication_id]) REFERENCES [medications] ([id])
GO

ALTER TABLE [prescriptions] ADD FOREIGN KEY ([medical_record_id]) REFERENCES [medical_records] ([id])
GO

-- 16 types are not this dialect's:
-- REVIEW: allergies.description is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: inventory_items.description is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: lab_results.result_details is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: inventory_categories.description is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: medications.description is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: departments.description is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: prescriptions.instructions is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: staff_roles.description is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: appointments.notes is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: admissions.primary_diagnosis is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: medical_records.diagnosis is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: medical_records.treatment_plan is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: doctors.biography is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: surgeries.description is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: insurance_policies.coverage_details is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
-- REVIEW: lab_tests.description is TEXT, which is PostgreSQL and MySQL rather than SQL Server, nearest is nvarchar(max).
