import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_map/building_details/bloc/buildings_bloc.dart';
import 'package:uni_map/building_details/bloc/buildings_event.dart';
import 'package:uni_map/building_details/bloc/buildings_state.dart';
import 'package:uni_map/building_details/widgets/building_home_card.dart';

class BuildingDetails extends StatefulWidget {
  const BuildingDetails({super.key});

  @override
  State<BuildingDetails> createState() => _BuildingDetailsPageState();
}

class _BuildingDetailsPageState extends State<BuildingDetails> {
  @override
  Widget build(BuildContext context) {
    final buildingBloc = BlocProvider.of<BuildingBloc>(context);

    return BlocListener<BuildingBloc, BuildingStates>(
      listener: (context, state) {
        print('success');
      },
      child: BlocBuilder<BuildingBloc, BuildingStates>(
        builder: (context, state) {
          if (state is InitialState) {
            final loginBloc = BlocProvider.of<BuildingBloc>(context);
            loginBloc.add(ApiBuildingEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UpdateState) {
            return getDetail(state.data);
          }
          return Container();
        },
      ),
    );
  }

  Center getDetail(List<dynamic> data) {
    var bodyDetail = Center(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0, 
          mainAxisSpacing: 8.0, 
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return BuildingHomeCard(
            requestId: data[index]['id'],
            name: data[index]['name'],
            //description: data[index]['description'],
          );
        },
      ),
    );
    return bodyDetail;
  }
}
