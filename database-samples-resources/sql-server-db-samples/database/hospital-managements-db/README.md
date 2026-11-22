# 🏥 Base de Datos de Gestión Hospitalaria

> **Visión general:** Esquema completo de base de datos relacional para la gestión hospitalaria: estructuras de tablas, definiciones de campos y un diagrama de relaciones. Puede editarlo en el Editor de bases de datos o navegar por el resto de los esquemas de base de datos de ejemplo.

---

## 📊 Resumen Ejecutivo

| Métrica | Cantidad | Detalles |
| :--- | :---: | :--- |
| **Tablas** | **33** | Las más ocupadas son `patients`, `doctors` y `staff`. |
| **Campos** | **173** | Cada una de las tablas cuenta con su respectiva clave primaria (`PK`). |
| **Relaciones (FK)** | **37** | 7 de estas claves foráneas convergen en `patients`. |

---

## 📖 Introducción al Esquema de la Base de Datos de Gestión Hospitalaria

En el ecosistema sanitario moderno, los datos son tan críticos como la experiencia clínica. Una base de datos de gestión hospitalaria robusta y altamente normalizada actúa como columna vertebral tecnológica de una institución médica. Integra las operaciones clínicas, administrativas, financieras y de cadena de suministro en un sistema unificado.

Este esquema completo, compuesto por **33 tablas interconectadas**, está diseñado para garantizar la integridad de los datos, eliminar redundancias y facilitar flujos de trabajo fluidos en los distintos departamentos hospitalarios. Al organizar datos sanitarios complejos en estructuras lógicas, este modelo de base de datos ayuda a los administradores hospitalarios y al personal clínico a ofrecer una atención óptima a los pacientes, manteniendo al mismo tiempo la eficiencia operativa y la transparencia financiera.

---

## 🎯 Descripción General y Alcance de la Base de Datos

El alcance de este diseño de base de datos es amplio y abarca todas las áreas funcionales principales de un hospital de cuidados terciarios. Con **33 tablas**, la base de datos está estructurada para gestionar el ciclo de vida completo de pacientes, personal, intervenciones clínicas y activos de las instalaciones. El esquema se divide en varios módulos altamente funcionales:

1. **Gestión del paciente y clínica:** Recoge datos demográficos, historiales médicos, alergias y datos diagnósticos.
2. **Recursos Humanos y Programación:** Gestiona al personal hospitalario, los roles médicos especializados y los horarios de turnos.
3. **Gestión de instalaciones y camas:** Rastrea la distribución física del hospital desde los departamentos y salas hasta las camas individuales.
4. **Diagnóstico e intervenciones quirúrgicas:** Coordina procedimientos médicos complejos, pruebas de laboratorio y resultados.
5. **Finanzas, Facturación y Seguros:** Agiliza la facturación de pacientes, el procesamiento de pagos y las reclamaciones de seguros.
6. **Inventario y cadena de suministro:** Supervisa los suministros médicos, gestiona las relaciones con proveedores y realiza seguimiento de las adquisiciones.

---

## 🗂️ Tablas Clave y Desglose Estructural

Para comprender la profundidad de esta Base de Datos de Gestión Hospitalaria, debemos examinar las tablas específicas que rigen cada área operativa. En el núcleo de las operaciones clínicas están las tablas de pacientes, médicos y personal.

* **Núcleo Clínico y Personal:**
  * `patients`: Almacena información demográfica y de contacto de emergencia vital.
  * `allergies` y `patient_allergies`: Priorizan la seguridad clínica mapeando sensibilidades específicas a los pacientes con distintos niveles de gravedad.
  * `staff` y `staff_roles`: Actúan como registro maestro para todos los empleados, categorizados por rol y asignados a departamentos específicos.
  * `doctors`: Detalla a los médicos haciendo referencia a sus licencias médicas únicas, especialidades y biografías profesionales.

* **Infraestructura Física:**
  * Modelada jerárquicamente: `departments` enlaza con `wards` (salas), que se subdividen en `rooms` (habitaciones), que finalmente contienen `beds` (camas individuales).
  * `admissions`: Registra la cama exacta ocupada por un paciente, junto con sus horarios de ingreso y alta y el diagnóstico principal.

* **Intervenciones Clínicas y Diagnóstico:**
  * `medical_records`, `prescriptions` y `prescription_items`: Documentan las intervenciones clínicas, con `prescription_items` vinculada directamente a `medications`.
  * `lab_tests`, `lab_requests` y `lab_results`: Gestionan los flujos de trabajo diagnósticos, garantizando que los técnicos puedan registrar los hallazgos directamente vinculados a la orden médica de origen.

* **Control Financiero y Logística:**
  * `billing`, `billing_items` y `payments`: Regulan el control administrativo financiero, interactuando con `insurance_providers` e `insurance_policies` para garantizar un cálculo preciso de cobertura.
  * `suppliers`, `inventory_items`, `inventory_categories`, `purchase_orders` y `purchase_order_items`: Gestionan el lado logístico donde los proveedores suministran ítems categorizados que se reponen mediante órdenes de compra.

---

## 🔗 Relaciones de Datos e Integridad Relacional

La fortaleza de esta base de datos radica en su estricta integridad relacional, reforzada mediante restricciones de clave foránea (`FOREIGN KEY`). Estas relaciones garantizan que no puedan existir datos huérfanos y que los registros históricos se mantengan consistentes a lo largo del tiempo.

* **Jerarquía Física:**
  * `wards.department_id` ──▶ `departments.id`
  * `rooms.ward_id` ──▶ `wards.id`
  * `beds.room_id` ──▶ `rooms.id`
  * `admissions.bed_id` ──▶ `beds.id`
  * Cuando un paciente es ingresado, `admissions.bed_id` se conecta directamente a una cama específica, permitiendo un seguimiento en tiempo real de la capacidad de la planta.

* **Circuito Clínico:**
  * Una entrada en `medical_records` vincula a un paciente con un médico. Si ese registro conduce a una prescripción, la clave foránea `prescriptions.medical_record_id` mantiene ese contexto exacto. Los medicamentos específicos recetados se registran en `prescription_items`, que asigna `prescription_id` a `prescriptions.id` y `medication_id` a `medications.id`. Esto evita errores al garantizar que cada medicación dispensada esté vinculada a un historial médico autorizado y a un médico prescritor.

* **Módulo Financiero:**
  * Vincula `payments` y `billing_items` directamente a una factura maestra a través de `billing_id`. Este enfoque estructurado garantiza que las auditorías estén limpias y que cada céntimo recibido pueda contabilizarse en relación con los servicios específicos prestados al paciente.

---

## 🔄 Funcionalidad Básica y Flujos de Trabajo Clínicos

Este esquema de base de datos soporta flujos de trabajo clínicos y administrativos complejos y de varios pasos. Así es como se procesa un recorrido típico del paciente a través del sistema:

1. **Programación y consulta:** Un paciente programa una cita, registrada en `appointments`, vinculando `patient_id` y `doctor_id`. Durante la consulta, el médico crea una entrada en `medical_records` detallando el diagnóstico y el plan de tratamiento.
2. **Pruebas diagnósticas:** Si se requieren pruebas, el médico presenta una solicitud en `lab_requests` haciendo referencia a `medical_records` y al `lab_tests` específico. Una vez que el técnico de laboratorio realiza la prueba, registra los resultados en `lab_results`, haciendo referencia a la solicitud original.
3. **Ingreso hospitalario y cirugía:** Si se requiere hospitalización, se realiza una inscripción en `admissions`, asignando al paciente una cama disponible en `beds`. Si la cirugía está programada, se registra en `surgical_procedures`, vinculando el historial de ingresos, la cirugía específica de la tabla `surgeries` y el cirujano principal de `doctors`.
4. **Aprobación y facturación:** Al dar de alta, la admisión del paciente queda cerrada. Se genera una factura en `billing`, con cargos detallados añadidos a `billing_items`. El sistema revisa `insurance_policies` activos para determinar la cobertura, y los pagos finales se registran en `payments`.

---

## 🚀 Casos de Uso Prácticos

Esta base de datos es altamente versátil y puede utilizarse para varias aplicaciones a nivel empresarial:

* **Sistemas de Historial Médico Electrónico (EHR):** Sirviendo como backend para portales clínicos donde los médicos visualizan en tiempo real el historial médico de los pacientes, las alergias y los resultados de laboratorio.
* **ERP hospitalario y sistemas de inventario:** Automatizar alertas a nivel de stock para `inventory_items` y generar automáticamente `purchase_orders` cuando el stock cae por debajo de umbrales críticos.
* **Paneles de asignación de recursos:** Proporcionar tasas de ocupación en tiempo real de camas, habitaciones y salas para optimizar los ingresos de pacientes y reducir los tiempos de espera.
* **Herramientas de auditoría financiera:** Permitir que los equipos de gestión del ciclo de ingresos concilien facturación, pagos y reclamaciones de seguros de forma eficiente.

---

## ✅ Ventajas de este Diseño de Base de Datos

Implementar este esquema normalizado ofrece beneficios sustanciales para los proveedores de salud:

* **Seguridad del paciente:** Al vincular `patient_allergies` directamente con `patients`, el sistema puede detectar posibles conflictos de alergia a medicamentos antes de que la receta se finalice en `prescription_items`.
* **Eficiencia operativa:** La programación automatizada y el seguimiento de camas reducen la carga administrativa, permitiendo al personal centrarse en la atención al paciente.
* **Cumplimiento normativo:** Garantiza la auditoría financiera completa, lo cual es vital para navegar estructuras complejas de seguros sanitarios y mandatos gubernamentales.

---

## ⚙️ Mejores Prácticas de Implementación y Escalabilidad

Para desplegar con éxito esta base de datos de gestión hospitalaria, los administradores de bases de datos deben seguir las mejores prácticas clave del sector:

* **Seguridad y Cumplimiento:** Dada la naturaleza sensible de los datos médicos, implementar un estricto control de acceso y cifrado en reposo y en tránsito es obligatorio para cumplir con normativas como **HIPAA**.
* **Optimización de Índices:** Los índices deben colocarse en claves foráneas y fechas consultadas con frecuencia:
  * `appointments.appointment_date`
  * `admissions.admission_date`
  * `medical_records.patient_id`
* **Particionamiento:** Para entornos de alto volumen, particionar tablas históricas como `lab_results` o `payments` por fecha puede evitar la degradación del rendimiento.
* **Automatización (Triggers):** Implementar activadores de base de datos en `inventory_items` puede automatizar actualizaciones de stock en tiempo real cuando se cumplen pedidos de compra o se dispensan medicamentos.

---

## 📝 Conclusión

Una base de datos de gestión hospitalaria bien estructurada es la base de una atención sanitaria moderna basada en datos. Al utilizar este esquema de **33 tablas**, los centros sanitarios pueden integrar sin problemas flujos de trabajo clínicos, tareas administrativas, seguimiento financiero y logística de la cadena de suministro. Este diseño integral no solo minimiza la redundancia de datos, sino que también establece un entorno seguro, escalable y altamente eficiente que capacita a los profesionales sanitarios para ofrecer una atención al paciente más segura, rápida y eficaz.

---

### 💡 En resumen: Base de Datos de Gestión Hospitalaria

* **33 tablas**, las más ocupadas de ellas `patients`, `doctors` y `staff`.
* **173 campos** en esas tablas, cada uno de los cuales tiene una clave primaria.
* **37 relaciones de clave foránea**, 7 de ellas reunidas en `patients`.
* **Editable en el navegador:** Ábrelo en el Editor de bases de datos y cambia cualquier cosa. Con 33 tablas y 37 relaciones ya mapeadas, es un punto de partida de trabajo para un nuevo proyecto o una referencia para aprender cómo encaja un esquema de este tamaño.