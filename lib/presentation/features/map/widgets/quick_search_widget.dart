// File: lib/presentation/shared/widgets/quick_search_widget.dart
import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';
import 'package:medigo/service/drug_search_service.dart';

import '../screens/drug_search_results_screen.dart';

class QuickSearchWidget extends StatefulWidget {
  final String? hintText;
  final bool showSuggestions;
  final VoidCallback? onFocus;

  const QuickSearchWidget({
    Key? key,
    this.hintText,
    this.showSuggestions = true,
    this.onFocus,
  }) : super(key: key);

  @override
  _QuickSearchWidgetState createState() => _QuickSearchWidgetState();
}

class _QuickSearchWidgetState extends State<QuickSearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && widget.onFocus != null) {
        widget.onFocus!();
      }
    });
  }

  void _onSearchChanged(String query) async {
    if (!widget.showSuggestions) return;

    if (query.length >= 2) {
      try {
        final suggestions = await DrugSearchService.getMedicationSuggestions(query);
        if (mounted) {
          setState(() {
            _suggestions = suggestions;
            _showSuggestions = true;
          });
        }
      } catch (e) {
        // Handle error silently
      }
    } else {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
    }
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;

    _clearSuggestions();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrugSearchResultsScreen(searchQuery: query),
      ),
    );
  }

  void _clearSuggestions() {
    setState(() {
      _showSuggestions = false;
      _suggestions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search field
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onSearchChanged,
            onSubmitted: _performSearch,
            decoration: InputDecoration(
              hintText: widget.hintText ?? "Chercher un médicament...",
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).focusColor,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).focusColor,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  _clearSuggestions();
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),

        // Suggestions dropdown
        if (_showSuggestions && _suggestions.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Suggestions",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: _clearSuggestions,
                        child: Text(
                          "Fermer",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Suggestions list
                ..._suggestions.take(5).map((suggestion) {
                  return InkWell(
                    onTap: () {
                      _controller.text = suggestion;
                      _clearSuggestions();
                      _performSearch(suggestion);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.medication,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(width: AppSpacing.space16(context)),
                          Expanded(
                            child: Text(
                              suggestion.toUpperCase(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Icon(
                            Icons.arrow_outward,
                            size: 16,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}