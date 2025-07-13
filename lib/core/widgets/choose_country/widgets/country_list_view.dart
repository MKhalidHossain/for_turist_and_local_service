import 'package:flutter/material.dart';
import '../model/country.dart';
import '../data/countries.dart';

typedef CountrySelectCallback = void Function(Country country);
typedef CustomFlagBuilder = Widget Function(Country country);

class CountryListView extends StatefulWidget {
  final CountrySelectCallback onSelect;
  final List<String>? favorite; // list of country codes to pin on top
  final List<String>? exclude; // list of country codes to hide
  final List<String>? countryFilter; // list of country codes to only include
  final bool showPhoneCode;
  final bool searchAutofocus;
  final bool showWorldWide;
  final bool showSearch;
  final CustomFlagBuilder? customFlagBuilder;

  const CountryListView({
    super.key,
    required this.onSelect,
    this.favorite,
    this.exclude,
    this.countryFilter,
    this.showPhoneCode = false,
    this.searchAutofocus = false,
    this.showWorldWide = false,
    this.showSearch = true,
    this.customFlagBuilder,
  });

  @override
  State<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  late List<Country> _filteredCountries;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  void _applyFilters() {
    List<Country> filtered = countries;

    if (widget.exclude != null && widget.exclude!.isNotEmpty) {
      filtered = filtered
          .where((c) => !widget.exclude!.contains(c.countryCode))
          .toList();
    }

    if (widget.countryFilter != null && widget.countryFilter!.isNotEmpty) {
      filtered = filtered
          .where((c) => widget.countryFilter!.contains(c.countryCode))
          .toList();
    }

    _filteredCountries = filtered;
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredCountries = countries
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  List<Country> _getFavoriteCountries() {
    if (widget.favorite == null || widget.favorite!.isEmpty) {
      return [];
    }
    return countries
        .where((c) => widget.favorite!.contains(c.countryCode))
        .toList();
  }

  Widget _buildFlag(Country country) {
    if (widget.customFlagBuilder != null) {
      return widget.customFlagBuilder!(country);
    }
    return Text(
      country.flagEmoji,
      style: const TextStyle(fontSize: 24),
    );
  }

  Widget _buildCountryTile(Country country) {
    return ListTile(
      leading: _buildFlag(country),
      title: Text(country.name),
      trailing: widget.showPhoneCode
          ? Text("+${_getPhoneCode(country.countryCode)}")
          : null,
      onTap: () => widget.onSelect(country),
    );
  }

  String _getPhoneCode(String countryCode) {
    // Stub: You can map countryCode to phone codes here
    return "XXX";
  }

  @override
  Widget build(BuildContext context) {
    final favorites = _getFavoriteCountries();

    return Column(
      children: [
        if (widget.showSearch)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: widget.searchAutofocus,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search country",
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
        Expanded(
          child: ListView(
            children: [
              if (favorites.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Favorites", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...favorites.map(_buildCountryTile),
                const Divider(),
              ],
              ..._filteredCountries.map(_buildCountryTile),
            ],
          ),
        ),
      ],
    );
  }
}
