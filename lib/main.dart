import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raúl Millán Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final myController = TextEditingController();
  final String title = 'Raúl Millán Moreno';
  final _formKey = GlobalKey<FormBuilderState>();
  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormBuilder(
                key: _formKey, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    FormBuilderChoiceChip<String>(// estas son las choice chips del inicio
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()],
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Choice chips',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          )
                        )
                      ),
                      name: 'languages_choice',                      
                      options: const [
                        FormBuilderChipOption(//primera opcion
                          value: 'Flutter',
                          avatar: FlutterLogo(
                            size: 50,
                          ), 
                          child: Chip(
                            label: Text('Flutter'),
                            backgroundColor: Colors.blue,                            
                            ),
                        ),
                        FormBuilderChipOption(//segunda opcion
                          value: 'Android',
                          avatar: SizedBox.shrink(), 
                          child: Chip(
                            label: Text('Android'),
                            backgroundColor: Colors.blue,                            
                          ),
                        ),
                        FormBuilderChipOption(//tercera opcion
                          value: 'Chrome OS',
                          avatar: SizedBox.shrink(),  
                          child: Chip(
                            label: Text('Chrome OS'),
                            backgroundColor: Colors.blue,                            
                            ),
                        ),
                      ],
                      onChanged: _onChanged,
                    ),
                    
                    const SizedBox(height: 20),

                     FormBuilderSwitch(// el switch que representa si aceptas los terminos y condiciones.
                      title: const Text('I Accept the terms and conditions'),
                      name: 'accept_terms_switch',
                      onChanged: _onChanged,
                      decoration: const InputDecoration(
                        labelText: 'Switch',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          )
                        )
                      ),
                    ),

                    const SizedBox(height: 20),

                    FormBuilderTextField(//este es un campo de texto, el cual es la tercera parte del formulario
                      name: 'text_f',
                      decoration: InputDecoration(
                        labelText: 'Text Field',
                        prefix: Text('A ', style: TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.black, decorationThickness: 1.5),), 
                        filled: true, 
                        fillColor: Colors.transparent, 
                        border: OutlineInputBorder(                          
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0, 
                          ),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Este campo es obligatorio.'),
                        FormBuilderValidators.maxLength(15,
                          errorText: 'Máximo 15 caracteres'),
                      ]),   
                      onChanged: _onChanged,                   
                    ),
            
                    const SizedBox(height: 20),

                    FormBuilderDropdown<String>(// es el dropdown que te hace seleccionar entre tres paises
                      name: 'drdown',
                      decoration: InputDecoration(
                        labelText: 'Dropdown Field',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()],
                      ),
                      items: ['Findland', 'Spain', 'United Kindom']
                          .map((lang) => DropdownMenuItem(
                                value: lang,
                                child: Text(lang),
                              ))
                          .toList(),
                      onChanged: _onChanged,
                    ),
                    const SizedBox(height: 20),

                    FormBuilderRadioGroup<String>(// estos son los radio buttonst 
                      initialValue: null,
                      name: 'rgrup',
                      decoration: const InputDecoration(
                        labelText: 'Radio Group Model',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          )
                        )
                      ),
                      onChanged: _onChanged,
                      orientation: OptionsOrientation.vertical,
                      validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(errorText: 'Es necesario seleccionar una opción')]),
                      options:  const [
                        FormBuilderFieldOption(value: 'Option 1'),                        
                        FormBuilderFieldOption(value: 'Option 2'),
                        FormBuilderFieldOption(value: 'Option 3'),
                        FormBuilderFieldOption(value: 'Option 4'),
                      ],
                      controlAffinity: ControlAffinity.leading,
                    ),                    
                  ],
                ),
              )
            ],
          )        
        )        
      ),
      
      floatingActionButton: FloatingActionButton(// este es el boton flotante donde al pulsarlo mostrara los datos de lo que has seleccionado.
        onPressed: () {       
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            final formValues = _formKey.currentState!.value;
            showDialog(context: context,
              barrierDismissible: true, 
              builder: (BuildContext context){
                return AlertDialog(
                  icon: const Icon(Icons.check_circle),                
                  title: const Text('Submission Completed'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'choice_chips: ${formValues['languages_choice'] ?? 'No seleccionado'}'),
                      Text(
                        'switch: ${formValues['accept_terms_switch'] ?? 'No seleccionado'}'),
                      Text(
                        'TextField: ${formValues['text_f'] ?? 'No seleccionado'}'),
                      Text(
                        'dropdown: ${formValues['drdown'] ?? 'No seleccionado'}'),
                      Text(
                        'radioGroup: ${formValues['rgrup'] ?? 'No seleccionado'}'),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },          
            ); 
          }             
        },
        child: const Icon(Icons.upload),
      ),

    );
  }
}